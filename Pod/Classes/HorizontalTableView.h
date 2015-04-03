//
//  HorizontalTableView.h
//  HorizontalTableView
//
//  Created by James Evans on 2015-04-03.
//  Copyright (c) 2015 Jamie Riley Evans. All rights reserved.
//

@protocol HorizontalTableViewDataSource;
@interface HorizontalTableView : UITableView <UITableViewDataSource>

@property (nonatomic) id <HorizontalTableViewDataSource> horizontalDataSource;

@property (nonatomic) CGFloat rowWidth;
// Insets between the sides and the first and last views
@property (nonatomic) CGFloat horizontalPadding;

- (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier;

// You must create this table view programmatically with initWithFrame:
- (id)init UNAVAILABLE_ATTRIBUTE;
- (id)initWithCoder:(NSCoder *)aDecoder UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style UNAVAILABLE_ATTRIBUTE;

// Use horizontalDataSource, instead
// dataSource is set to 'self'
- (void)setDataSource:(id<UITableViewDataSource>)dataSource UNAVAILABLE_ATTRIBUTE;

@end

#pragma mark - HorizontalTableView Data Source -

@protocol HorizontalTableViewDataSource <NSObject>
@required

- (NSInteger)tableView:(HorizontalTableView *)tableView numberOfRowsInSection:(NSInteger)section;

@optional

- (CGFloat)numberOfSectionsInTableView:(HorizontalTableView *)tableView;

- (NSString *)identifierForTableView:(HorizontalTableView *)tableView;
- (NSString *)identifierForTableView:(HorizontalTableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(HorizontalTableView *)tableView widthForRowAtIndexPath:(NSIndexPath *)indexPath;

// Utilizes static views
- (UIView *)tableView:(HorizontalTableView *)tableView viewForRowAtIndexPath:(NSIndexPath *)indexPath;
// Utilizes reusable views
// Pairs well with subviewOfClass:
- (void)tableView:(HorizontalTableView *)tableView initializeView:(UIView *)contentView atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(HorizontalTableView *)tableView updateView:(UIView *)contentView atIndexPath:(NSIndexPath *)indexPath;

@end
