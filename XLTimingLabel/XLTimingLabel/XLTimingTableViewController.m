//
//  XLTimingTableViewController.m
//  XLTimingLabel
//
//  Created by 谢小雷 on 16/2/23.
//  Copyright © 2016年 *. All rights reserved.
//

#import "XLTimingTableViewController.h"
#import "XLTimingTableViewCell.h"
#import "XLTimingModel.h"
@interface XLTimingTableViewController ()
@property (copy, nonatomic) NSArray *models;
@end

@implementation XLTimingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissMySelf:)];
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XLTimingTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XLTimingTableViewCell class])];
    
    arc4random();
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<100; i++) {
        XLTimingModel *model = [[XLTimingModel alloc] init];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:random()];
        model.date = date;
        [array addObject:model];
    }
    self.models = array.copy;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissMySelf:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLTimingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XLTimingTableViewCell class]) forIndexPath:indexPath];
    
    // Configure the cell...
    cell.timingModel = self.models[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
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
