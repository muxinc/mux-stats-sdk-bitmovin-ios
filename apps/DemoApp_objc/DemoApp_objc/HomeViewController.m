//
//  HomeViewController.m
//  DemoApp_objc
//
//  Created by Stephanie Zuñiga on 17/3/22.
//

#import "HomeViewController.h"
#import "PlayerViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
}

- (void)setupLayout {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.navigationController setNavigationBarHidden:YES];
    
    UIButton *openPlayerButton = [UIButton new];
    [openPlayerButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [openPlayerButton setBackgroundColor: UIColor.lightGrayColor];
    [openPlayerButton.layer setCornerRadius:4.0];
    [openPlayerButton setTitleColor: UIColor.labelColor forState: UIControlStateNormal];
    [openPlayerButton setTitle: @"Open Player" forState: UIControlStateNormal];
    
    [openPlayerButton addTarget:self action:@selector(openPlayerViewController) forControlEvents:UIControlEventPrimaryActionTriggered];
    
    [self.view addSubview:openPlayerButton];
    
    double padding = UIScreen.mainScreen.bounds.size.width * 0.10;
    double buttonHeight = (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomTV) ? (UIScreen.mainScreen.bounds.size.height * 0.1) : 44.0;
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:openPlayerButton
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1
                                                                constant:padding];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:openPlayerButton
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1
                                                                constant:-padding];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:openPlayerButton
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:openPlayerButton
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1
                                                                constant:buttonHeight];
    
    [openPlayerButton addConstraint: height];
    [self.view addConstraints:@[leading, trailing, centerY]];
}

- (void)openPlayerViewController {
    PlayerViewController *viewController = [PlayerViewController new];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
