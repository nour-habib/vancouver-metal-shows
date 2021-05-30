//
//  DetailViewController.m
//  VancouverMetalShows_v2.0
//  Created by Nour Habib on 2021-05-02.
//  Copyright © 2021 Nour. All rights reserved.


#import "DetailViewController.h"


@interface DetailViewController ()

@property (nonatomic, readwrite) FIRFirestore *db;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"artistLabel: %@", self.showModel.artist);
    _artistLabel.text = self.showModel.artist;
    _venueLabel.text = self.showModel.venue;
    _dateLabel.text = self.showModel.date;
    
    if(self.showModel.supportingArtists.length!=0)
    {
        _suppArtLabel.text = self.showModel.supportingArtists;
    }
    else
    {
        [self.suppArtLabel setHidden:YES];
    }
    
    _artistImageview.image = [UIImage imageNamed:self.showModel.artistImage];
    self.navigationItem.title = _artistLabel.text;
    [self showMap];
    
    _addToFavsButton.layer.cornerRadius = 10;
    _addToFavsButton.clipsToBounds = YES;
    
    _shareButton.layer.cornerRadius = 10;
    _shareButton.clipsToBounds = YES;
    
    _getTicketsButton.layer.cornerRadius = 10;
    _getTicketsButton.clipsToBounds = YES;
    
    
    self.title = self.showModel.artist;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
   
    
    
 
}

- (void)showMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.8683
                                                             longitude:151.2086
                                                                  zoom:6];
     GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(10, 350, 300, 200) camera:camera];
     mapView.myLocationEnabled = YES;
     [self.view addSubview:mapView];
   // mapView.center = self.view.center;
    //mapView.constraints

     // Creates a marker in the center of the map.
     GMSMarker *marker = [[GMSMarker alloc] init];
     marker.position = CLLocationCoordinate2DMake(-33.8683, 151.2086);
     marker.title = @"Sydney";
     marker.snippet = @"Australia";
     marker.map = mapView;
    
}

-(IBAction)addToFavs:(id)sender
{
    self.db = [FIRFirestore firestore];
    
    NSDictionary *dataToAdd = @{@"artist": _showModel.artist,
                                @"date": _showModel.date,
                                @"supporting_artists": _showModel.supportingArtists,
                                @"tickets": _showModel.tickets,
                                @"venue": _showModel.venue,
                                @"artist_image":_showModel.artistImage
    };
    

[[[self.db collectionWithPath:@"vms"] documentWithAutoID] setData:dataToAdd
    completion:^(NSError * _Nullable error) {
      if (error != nil) {
        NSLog(@"Error writing document: %@", error);
      } else {
        NSLog(@"Document successfully written!");
      }
    }];

    
    //NSLog(@"test");
}


-(IBAction)shareAction:(id)sender
{
    //NSLog(@"Buttonpressed:");
    NSArray* sharedObjects=[NSArray arrayWithObjects:@"sharecontent",  nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(IBAction)getTickets:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"http://www.ticketmaster.ca"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (!success) {
             NSLog(@"url failed to open");
        }
    }];
}




@end
