//
//  ViewController.m
//  UIViewAnimationTransition
//
//  Created by Cantoraz Chou on 7/11/16.
//
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIView* containerView;
@property (nonatomic, weak) IBOutlet UIView* ipadContainerView;
@property (nonatomic, weak) IBOutlet UIView* iphoneContainerView;

@property (nonatomic, weak) IBOutlet UILabel*   label;
@property (nonatomic, weak) IBOutlet UIButton*  button;

@property (nonatomic, strong) UIImageView* ipadView;
@property (nonatomic, strong) UIImageView* iphoneView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Prepare ipadView
//    _ipadView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 35, 250, 128)];
    _ipadView = [[UIImageView alloc] initWithFrame:_ipadContainerView.bounds];
    _ipadView.image = [UIImage imageNamed:@"ipad"];
    
    // Prepare iphoneView
//    _iphoneView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 198, 88.5, 102.5)];
    _iphoneView = [[UIImageView alloc] initWithFrame:_iphoneContainerView.bounds];
    _iphoneView.image = [UIImage imageNamed:@"iphone"];
}

- (void)viewDidAppear:(BOOL)animated
{
//    [UIView transitionWithView:_ipadView duration:1.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//        [_containerView addSubview:_ipadView];
//        [_containerView addSubview:_iphoneView];
//    } completion:NULL];
    
    // Animated transit with ipadContainerView
    __caz__delay(0, ^{
        [UIView transitionWithView:_ipadContainerView duration:1.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [_ipadContainerView addSubview:_ipadView];
        } completion:NULL];
    });
    
    // Animated transit with iphoneContainerView
    __caz__delay(1, ^{
        [UIView transitionWithView:_iphoneContainerView duration:1.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [_iphoneContainerView addSubview:_iphoneView];
        } completion:NULL];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Recieved Actions

- (IBAction)go:(id)sender {
    // Animate to change background color
    [UIView animateWithDuration:.5 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:252/255.
                                                    green:155/255.
                                                     blue:65/255.
                                                    alpha:1];
    }];
    
    [UIView transitionWithView:_label duration:1.5 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        _label.hidden = true;
    } completion:NULL];
    
    // Prepare alliphonesView to replace iphoneContainerView
    UIImageView* alliphonesView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 35, 304, 90)];
    alliphonesView.image = [UIImage imageNamed:@"all_iphones"];
    
    // Animate to reposition iphoneContainerView
    [UIView animateWithDuration:1 delay:0 options:0 animations:^{
        _iphoneContainerView.frame = alliphonesView.frame;
        _iphoneView.frame = _iphoneContainerView.bounds;
    } completion:^(BOOL finished) {
        if (finished) {
            // Animated transit from iphoneContainerView to alliPhonesView
            [UIView transitionFromView:_iphoneContainerView
                                toView:alliphonesView
                              duration:0.33
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            completion:NULL];
        }
    }];
    
    // Prepare allipadsView to replace ipadContainerView
    UIImageView* allipadsView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 133, 304, 90)];
    allipadsView.image = [UIImage imageNamed:@"all_ipads"];
    
    // Animate to reposition ipadContainerView
    [UIView animateWithDuration:1 delay:1 options:0 animations:^{
        _ipadContainerView.frame = allipadsView.frame;
        _ipadView.frame = _ipadContainerView.bounds;
    } completion:^(BOOL finished) {
        if (finished) {
            // Animated transit from ipadContainerView to allipadsView
            [UIView transitionFromView:_ipadContainerView
                                toView:allipadsView
                              duration:0.33
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            completion:NULL];
        }
    }];
}

#pragma mark -

// Delay helper function
FOUNDATION_STATIC_INLINE void __caz__delay(NSTimeInterval delay, void (^ __nonnull completion)(void))
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        completion();
    });
}

@end
