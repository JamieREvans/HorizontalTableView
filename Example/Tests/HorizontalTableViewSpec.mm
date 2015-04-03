#import <Cedar/Cedar.h>
#import "HorizontalTableView.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HorizontalTableViewSpec)

describe(@"HorizontalTableView", ^{
    __block HorizontalTableView *subject;

    beforeEach(^{
        
        subject = [[HorizontalTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 200.0f)];
    });
    
    it(@"should have a transform applied", ^{
        
        subject.transform should equal(CGAffineTransformMakeRotation(-M_PI_2));
    });
});

SPEC_END
