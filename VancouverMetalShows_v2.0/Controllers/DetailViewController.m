//
//  DetailViewController.m
//  VancouverMetalShows_v2.0
//  Created by Nour Habib on 2021-05-02.
//  Copyright © 2021 Nour. All rights reserved.


#import "DetailViewController.h"


@interface DetailViewController ()

@property (nonatomic, readwrite) FIRFirestore *db;
@property (nonatomic, strong) GMSMapView *mapView;

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


//To Fix
- (void)showMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:49.2827
                                                             longitude:123.1207
                                                                 zoom:1];
     _mapView = [GMSMapView mapWithFrame:CGRectMake(10, 360, self.view.frame.size.width-20, self.view.frame.size.height-370) camera:camera];
    
    [self.view addSubview:_mapView];
    
     _mapView.myLocationEnabled = YES;
    _mapView.camera = camera;
    //_mapView.mapType = kGMSTypeSatellite;
    
     
   // mapView.center = self.view.center;


     // Creates a marker in the center of the map.
     GMSMarker *marker = [[GMSMarker alloc] init];
     marker.position = CLLocationCoordinate2DMake(49.2827, 123.1207);
//    mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 49.2827, longitude: 123.1207), zoom: 15, bearing: 0, viewingAngle: 0);
    
//    _mapView.camera = [GMSCameraPosition cameraWithLatitude:49.2827 longitude:123.1207 zoom:1];

//     marker.title = @"Sydney";
//     marker.snippet = @"Australia";
     marker.map = _mapView;


    
    

    
    
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
          
//          MainViewController *mv = [[MainViewController alloc]init];
//          [mv ShowAlert:@"Added"];
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
