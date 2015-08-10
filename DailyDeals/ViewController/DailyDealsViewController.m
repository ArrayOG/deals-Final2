//
//  DailyDealsViewController.m
//  DailyDeals
//
//  Created by MyAppTemplates Software on 07/04/14.
//  Copyright (c) 2014 MyAppTemplates Software. All rights reserved.
//

#import "DailyDealsViewController.h"
#import "DailyDealsCell.h"
#import "ProfileViewController.h"
#import "DealsDetailsViewController.h"
#import "Container.h"
#import "ADBMobile.h"
@interface DailyDealsViewController ()

@property BOOL useWEST;

@end

@implementation DailyDealsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.east = [[NSMutableArray alloc] init];
        self.west =[[NSMutableArray alloc] init];
        self.inApp = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [self setArrays];
    [self runLocationTargeting];
    //Add side bar on view
    self.appMenu=[[AppMenuView alloc] initWithNibName:@"AppMenuView" bundle:nil];
    
    self.appMenu.delegate=self;

    [self.viewAppMenu addSubview:self.appMenu.view];
   
   
   
    
}
#pragma mark UITableViewDelegate and UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier=@"DailyDealsCell";

        DailyDealsCell *cell=(DailyDealsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            UIViewController *controller = [[UIViewController alloc]initWithNibName:@"DailyDealsCell" bundle:nil];
            cell= (DailyDealsCell *)controller.view;
            
        }
       cell.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.inApp objectAtIndex:indexPath.row]]];
       cell.lblDealsTitle.text=@"Title";
    return cell;

   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"DailyDealsToDetails" sender:self];
}
-(IBAction)btnProfileClk:(id)sender
{
    [self performSegueWithIdentifier:@"DailyDealsToProfile" sender:self];
}
-(IBAction)btnSlideManuClk:(id)sender
{
   
    if(!self.btnSlide.selected){
        [self openAppMenu];
        self.btnSlide.selected=YES;
    }else{
       self.btnSlide.selected=NO;
        [self hideAppMenu];
    }
}
-(void)openAppMenu{
    
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tapGesture.delegate=self;
    [self.viewContainer addGestureRecognizer:tapGesture];
    [self moveByX:160.0 animated:YES];
    
}
-(void)hideAppMenu{
    // self.navBack.backgroundColor=[UIColor whiteColor];
    self.btnSlide.selected=NO;
    [self.viewContainer removeGestureRecognizer:tapGesture];
    [self moveByX:0.0 animated:YES];
}
-(void)tapAction:(id)sender
{
    if (self.appMenu) {
        [self hideAppMenu];
    }
}

#pragma mark - App menu delegates
-(void)menuSelected:(NSString *)selectedText
{
    //selected text
}

-(void)moveByX:(CGFloat)x animated:(BOOL)animated{
    
    CGRect rect=self.viewContainer.frame;
    
    rect.origin.x=x;
    
    if(animated){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        self.viewContainer.frame=rect;
        [UIView commitAnimations];
        
    }else{
        self.viewContainer.frame=rect;
    }
    
    
}


-(IBAction)btnSearchClk:(id)sender
{
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DailyDealsToProfile"]) {
        
         //ProfileViewController *newSegue=segue.destinationViewController;
        //Pass any value to dailyDetails ViewController if require
    }
    if ([segue.identifier isEqualToString:@"DailyDealsToProfile"]) {
        
        //DealsDetailsViewController *newSegue=segue.destinationViewController;
        //Pass any value to dailyDetails ViewController if require
    }
}

-(void) setArrays
{
    self.west = [NSMutableArray arrayWithObjects: @"lasvegas.jpg",
                 @"coachella.jpg",
                 @"halfmoonbay.png",
                 @"seattle.jpg",
                 nil];
    self.east = [NSMutableArray arrayWithObjects: @"niagrafalls.jpg",
                 @"LobsterDinner.jpg",
                 @"floridakeys.png",
                 @"broadway.png",
                 nil];
}


- (void) runLocationTargeting {
    /* Adobe Tracking - Target
     *
     * reset cookies to ensure target gives us a different experience depending on user's location choice
     * note: we are resetting cookies for this demo so the target server will allow us to reset experiences
     */
    [ADBMobile targetClearCookies];
    
    
    /* Adobe Tracking - Target
     *
     * create a request for the geo targeting location
     * default is black background and white text
     */
    ADBTargetLocationRequest *locationRequest = [ADBMobile targetCreateRequestWithName:@"content-campaign" defaultContent:@"westCoast" parameters:nil];
    
    /* Adobe Tracking - Target
     *
     * send our location request and in the callback, change the colors we get back from target
     */
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content) {
        
    [self performSelectorOnMainThread:@selector(setContent:) withObject:content waitUntilDone:NO];
    }];
}

-(void) setContent:(NSString *)chosen
{
    {
        if ([chosen isEqualToString:@"westCoast"]) {
            self.inApp = self.west;
        } else {
            self.inApp = self.east;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
