//
//  FavouritesTableViewController.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2020-02-28.
//  Copyright © 2020 Nour. All rights reserved.
//

#import "FavouritesTableViewController.h"
#import "FavShowTableViewCell.h"

@interface FavouritesTableViewController ()

@property(strong,nonatomic) NSMutableArray *favsArray;
@property (nonatomic, readwrite) FIRFirestore *db;

@end

@implementation FavouritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.db = [FIRFirestore firestore];
    self.favsArray = [NSMutableArray new];
    [self getCollection];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.favsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FavShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    if(cell==nil)
    {
        //NSLog(@"nil");
        cell = [[FavShowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seprater_line.png"]];
           imgView.frame = CGRectMake(0, 80, 320, 1);
           [cell.contentView addSubview:imgView];
    
    //NSLog(@"arr size: %lu",_favsArray.count);
    ShowModel *show = self.favsArray[indexPath.row];
   cell.showModel = show;
    
    //NSLog(@"show artst: %@",cell.showModel.artist);
 
    return cell;
}

//Get all files from Firebase

-(void) getCollection{

    
    [[self.db collectionWithPath:@"vms"]
         getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot,
                                      NSError * _Nullable error) {
 
           if (error != nil) {
             //NSLog(@"Error getting documents: %@", error);
           } else {
             for (FIRDocumentSnapshot *document in snapshot.documents) {
               //NSLog(@"%@ => %@", document.documentID, document.data);
                 
                 
                 NSString *artist = [document.data objectForKey:@"artist"];
                 NSString *date = [document.data objectForKey:@"date"];
                 NSString *supp_art = [document.data objectForKey:@"supporting_artists"];
                 NSString *tix = [document.data objectForKey:@"tickets"];
                 NSString *venue = [document.data objectForKey:@"venue"];
                 
                 ShowModel *show = [[ShowModel alloc] initWithArtist: artist withDate:date withVenue:venue withSupportingArtists:supp_art withTickets:tix withImage:@""];
//                 if(show==nil)
//                 {
//                     NSLog(@"show null bruh");
//                 }
//                 else
//                 {
//                     NSLog(@"show not null bruh");
//                 }
                 
                 [self.favsArray addObject:show];
                 
                 [self.tableView reloadData];
                 //NSLog(@"first obj: %@",_favsArray.firstObject);
                 
             }
           }
         }];
    
}

//Delete entry from database
-(void)deleteDocument:(NSString *) artistToDelete
{
    [[[self.db collectionWithPath:@"vms"] documentWithPath:artistToDelete]
          deleteDocumentWithCompletion:^(NSError * _Nullable error) {
            if (error != nil) {
              NSLog(@"Error removing document: %@", error);
            } else {
              NSLog(@"Document successfully removed!");
            }
      }];
    
    
}


//Enable swipe row

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//Delete row

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShowModel *show = self.favsArray[indexPath.row];
        NSString *art = show.artist;
        [self deleteDocument:art];
        [self.favsArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}



/*
 Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
