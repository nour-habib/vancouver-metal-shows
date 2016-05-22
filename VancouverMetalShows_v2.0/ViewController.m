//
//  ViewController.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour on 2016-05-01.
//  Copyright © 2016 Nour. All rights reserved.
//

#import "ViewController.h"
#import "ShowModel.h"
#import "CustomUITableViewCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *modelsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.modelsArray = [NSMutableArray new];
    [self urlRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) urlRequest{
    
    NSURL *url = [NSURL URLWithString:@"http://www.nourhabib.com/mysqljson/jsonMYSQL.php"];
    
    //allows downloading of data
    NSURLSession *session = [NSURLSession sharedSession];
    //sharedSession provides a single, basic connection

    
    //__weak typeof(self) weakSelf = self;
    //assign weak reference to self
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError = nil;
            
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&jsonError];
            
            
            //for loop
            for (NSDictionary *thisDict in jsonArray){
                
                NSString *artist = [thisDict objectForKey:@"artist"];
                NSString *date = [thisDict objectForKey:@"date"];
                NSString *venue = [thisDict objectForKey:@"venue"];
                NSString *supporting_artists = [thisDict objectForKey:@"supporting_artists"];
                NSString *tickets = [thisDict objectForKey:@"tickets"];
                
                ShowModel *showModel = [[ShowModel alloc] initWithArtist: artist withDate:date withVenue:venue withSupportingArtists:supporting_artists withTickets:tickets];
                
                [self.modelsArray addObject:showModel];
                
                
            }
            
                //UI updates has to be in main queue
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                
                });
                        
            
        }
    }];
    
    [task resume];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.modelsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    ShowModel *model = self.modelsArray[indexPath.row];
    cell.showModel = model;
    
    //populate cell with artist
//    cell.textLabel.text = model.artist;
    
    
    return cell;
    
    
}

@end
