//
// TransitionController.m
//
// Created by XJones on 11/25/11.
//

#import "TransitionController.h"

@implementation TransitionController

@synthesize containerView = _containerView,
viewController = _viewController, previousViewController = _previousViewController;

- (id)initWithViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        _viewController = viewController;
    }
    return self;
}

- (void)loadView
{
    self.wantsFullScreenLayout = NO;
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.view = view;
    
    _containerView = [[UIView alloc] initWithFrame:view.bounds];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_containerView];
    
    [_containerView addSubview:self.viewController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.viewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)transitionToViewController:(UIViewController *)aViewController
                       withOptions:(UIViewAnimationOptions)options
{
    self.previousViewController = self.viewController;
    aViewController.view.frame = self.containerView.bounds;
    [UIView transitionWithView:self.containerView
                      duration:0.65f
                       options:options
                    animations:^{
                        
                        [self.viewController.view removeFromSuperview];
                        [self.containerView addSubview:aViewController.view];
                    }
                    completion:^(BOOL finished){
                        self.viewController = aViewController;
                    }];
}

-(void) transitionToPrevious {
    if (!self.previousViewController) {
        DLog(@"no previous vc");
        return;
    }
    self.previousViewController.view.frame = self.containerView.bounds;
    [UIView transitionWithView:self.containerView
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        
                        [self.viewController.view removeFromSuperview];
                        [self.containerView addSubview:self.previousViewController.view];
                    }
                    completion:^(BOOL finished){
                        self.viewController = self.previousViewController;
                        self.previousViewController = nil;
                        SafeRelease(_previousViewController);
                    }];

    
}

@end