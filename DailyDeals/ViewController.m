//
//  ViewController.m
//  DailyDeals
//
//  Created by MyAppTemplates Software on 07/04/14.
//  Copyright (c) 2014 MyAppTemplates Software. All rights reserved.
//

#import "ViewController.h"
#import "DailyDealsViewController.h"
#import "ADBMobile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    //Hide navigation bar and set scrollview contentSize
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.scrollView.contentSize=CGSizeMake(320, 560);
    
    [self socialMediaCampaign];
    [self welcomeMessageCampaign];
    [self helperBtnPressed];
    
}
#pragma mark Button Action
-(IBAction)btnLoginClk:(id)sender
{
    [self performSegueWithIdentifier:@"loginToDailyDeatls" sender:self];
}
-(IBAction)btnFacebookLoginClk:(id)sender
{
    [self performSegueWithIdentifier:@"loginToDailyDeatls" sender:self];
}
-(IBAction)btnTwitterClk:(id)sender
{
    [self performSegueWithIdentifier:@"loginToDailyDeatls" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if ([segue.identifier isEqualToString:@"loginToDailyDeatls"]) {
       
      // DailyDealsViewController *newSegue=segue.destinationViewController;
       //Pass any value to dailyDetails ViewController if require
   }
}
#pragma mark UITExtField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveScrollView:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.txtFieldEmail) {
        [self.txtFieldPassword becomeFirstResponder];
       
        
    }else if(textField==self.txtFieldPassword)
    {
        [self.txtFieldPassword resignFirstResponder];
        [self originalSizeScrollView:textField];
    }
    
    return YES;
}
#pragma mark ScrollView methods ::::::::::::::::::::::::::::::::::::::::::::

-(void)moveScrollView:(UIView *)theView{
    
    CGRect rc = [theView bounds];
    
    rc = [theView convertRect:rc toView:self.scrollView];
    CGPoint pt = rc.origin;
    pt.x = 0;
    pt.y=pt.y-150;
    
    [self.scrollView setContentOffset:pt animated:YES];
}

-(void)originalSizeScrollView:(UIView *)theView{
    
    CGRect rc = [theView bounds];
    
    rc = [theView convertRect:rc toView:self.scrollView];
    CGPoint pt = rc.origin;
    pt.x = 0;
    pt.y = 0;
    [self.scrollView setContentOffset:pt animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)welcomeMessageCampaign
{
    
    [ADBMobile targetClearCookies];
    
    ADBTargetLocationRequest* locationRequest = [ADBMobile targetCreateRequestWithName:@"welcome-message" defaultContent:@"Find Great Deals Everyday!" parameters:nil];
    
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content)
     
     {
         self.welcomeMessage.text = content;
         self.welcomeMessage.font = [UIFont fontWithName:@"Helvetica" size:13];
         self.welcomeMessage.numberOfLines = 0;
         
     }];
    
}

-(void)socialMediaCampaign
{
    [ADBMobile targetClearCookies];
    
    ADBTargetLocationRequest* locationRequest = [ADBMobile targetCreateRequestWithName:@"social-signup" defaultContent:@"Default Message" parameters:nil];
    
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content)
     
     {
         if ([content isEqualToString:@"fb"])
         {
             _btnTwitter.hidden = YES;
         }
         else if ([content isEqualToString:@"tw"])
         {
             _btnFacebook.hidden = YES;
         }
         else if ([content isEqualToString:@"no-social"])
         {
             _btnFacebook.hidden = YES;
             _btnTwitter.hidden = YES;
         }
         
     
}];
    

}

-(void)helperBtnPressed
{
//Declare variable that serves as a dictionary of parameters to be passed into a create request function
    _contextData = [NSMutableDictionary dictionary];

//Store information about how to further experience target based on which button was pressed, if any
    if (_btnTwitter.isSelected) {
        [_contextData setObject:@"Twitter" forKey:@"Social Media"];
    }
    
    else if (_btnFacebook.isSelected)
    {
        [_contextData setObject:@"Facebook" forKey:@"Social Media"];
    }

}

@end
