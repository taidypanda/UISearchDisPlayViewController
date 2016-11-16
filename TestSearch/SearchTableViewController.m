//
//  SearchTableViewController.m
//  TestSearch
//
//  Created by 苹果 on 15/9/15.
//  Copyright (c) 2015年 YDS. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()<UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplay;
@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchvc"];
    self.searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplay.searchResultsDataSource = self;
    _searchDisplay.searchResultsDelegate =self;
    _searchDisplay.searchResultsTableView.tableFooterView = [UIView new];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.definesPresentationContext = YES;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    self.searchResults = [self.dataArray filteredArrayUsingPredicate:resultPredicate];
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < searchText.length; i ++) {
        NSRange range = NSMakeRange(i, 1);
        NSString * str = [searchText substringWithRange:range];
        [arr addObject:str];
    }

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplay.searchResultsTableView) {
        return self.searchResults.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"searchvc" forIndexPath:indexPath];
    NSLog(@"self.searcharr = %@", self.searchResults);
    cell.textLabel.text = tableView != self.searchDisplay.searchResultsTableView ? self.dataArray[indexPath.row] : self.searchResults[indexPath.row];
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains %@[cd]",searchText];
    self.searchResults = [self.dataArray filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
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
