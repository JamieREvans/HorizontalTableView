//
//  HorizontalTableView.m
//  HorizontalTableView
//
//  Created by James Evans on 2015-04-03.
//  Copyright (c) 2015 Jamie Riley Evans. All rights reserved.
//

#import <UIKitPlus/UIKitPlus+Basic.h>
#import "HorizontalTableView.h"

#define DEFAULT_HORIZONTAL_TABLE_CELL_IDENTIFIER @"HorizontalTableViewCellIdentifier"

@interface HorizontalTableRotatedContentView : UIView
@end

@implementation HorizontalTableRotatedContentView
@end

@interface HorizontalTableView ()
{
    CGFloat width, height;
}

@end

@implementation HorizontalTableView

- (id)initWithFrame:(CGRect)frame
{
    CGPoint center = CGRectGetCenter(frame);
    CGRect newFrame = CGRectMake(0.0f, 0.0f, frame.size.height, frame.size.width);
    if(self = [super initWithFrame:newFrame style:UITableViewStylePlain])
    {
        width = frame.size.width, height = frame.size.height;
        
        [super setDataSource:self];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
        [self setCenter:center];
        [self setRowHeight:width];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setClipsToBounds:YES];
        [self setPagingEnabled:NO];
        [self setAllowsSelection:YES];
        [self setShowsVerticalScrollIndicator:NO];
    }
    return self;
}

- (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    return [cell.contentView subviewOfClass:[HorizontalTableRotatedContentView class]];
}

- (void)setRowWidth:(CGFloat)rowWidth
{
    _rowWidth = rowWidth;
    
    [self setRowHeight:rowWidth];
}

- (void)setHorizontalPadding:(CGFloat)horizontalPadding
{
    _horizontalPadding = horizontalPadding;
    
    [self setContentInset:UIEdgeInsetsMake(horizontalPadding, self.contentInset.left, horizontalPadding, self.contentInset.right)];
    [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y ? self.contentOffset.y : -horizontalPadding)];
}

#pragma mark - Convenience Overrides -

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    height = CGRectGetHeight(frame);
}

#pragma mark - Table View Methods -

- (CGFloat)widthForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.rowWidth)
    {
        return self.rowWidth;
    }
    else if([self.horizontalDataSource respondsToSelector:@selector(tableView:widthForRowAtIndexPath:)])
    {
        return [self.horizontalDataSource tableView:self widthForRowAtIndexPath:indexPath];
    }
    else if([self.horizontalDataSource respondsToSelector:@selector(tableView:viewForRowAtIndexPath:)])
    {
        return CGRectGetWidth([self.horizontalDataSource tableView:self viewForRowAtIndexPath:indexPath].bounds);
    }
    else return 0.0f;
}

- (NSString *)identifierForIndexPath:(NSIndexPath *)indexPath
{
    if([self.horizontalDataSource respondsToSelector:@selector(identifierForTableView:)])
    {
        return [self.horizontalDataSource identifierForTableView:self];
    }
    else if([self.horizontalDataSource respondsToSelector:@selector(identifierForTableView:atIndexPath:)])
    {
        return [self.horizontalDataSource identifierForTableView:self atIndexPath:indexPath];
    }
    else
    {
        return DEFAULT_HORIZONTAL_TABLE_CELL_IDENTIFIER;
    }
}

- (CGFloat)tableView:(UIView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self widthForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.horizontalDataSource tableView:self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self identifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        // Create and add content view
        HorizontalTableRotatedContentView *contentView = [[HorizontalTableRotatedContentView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.rowWidth, height)];
        [contentView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [contentView setCenter:CGPointMake(height/2.0f, self.rowWidth/2.0f)];
        [cell.contentView addSubview:contentView];
        
        // Setup content view
        if([self.horizontalDataSource respondsToSelector:@selector(tableView:initializeView:atIndexPath:)])
        {
            [self.horizontalDataSource tableView:self initializeView:contentView atIndexPath:indexPath];
        }
    }
    
    // Update content view size
    UIView *contentView = [cell.contentView subviewOfClass:[HorizontalTableRotatedContentView class]];
    CGFloat rowWidth = [self widthForRowAtIndexPath:indexPath];
    if(contentView.height != rowWidth)
    {
        [contentView setHeight:rowWidth];
        [contentView setCenter:CGPointMake(height/2.0f, rowWidth/2.0f)];
    }
    
    // Update view content
    if([self.horizontalDataSource respondsToSelector:@selector(tableView:viewForRowAtIndexPath:)])
    {
        [contentView removeSubviews];
        [contentView addSubview:[self.horizontalDataSource tableView:self viewForRowAtIndexPath:indexPath]];
    }
    else if([self.horizontalDataSource respondsToSelector:@selector(tableView:updateView:atIndexPath:)])
    {
        [self.horizontalDataSource tableView:self updateView:contentView atIndexPath:indexPath];
    }
    
    return cell;
}

@end