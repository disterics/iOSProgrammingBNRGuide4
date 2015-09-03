//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by disterics on 8/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

- (instancetype) init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype) initWithStyle:(UITableViewStyle) style
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        for (int i = 0; i < 5; ++i)
        {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (UIView *)headerView
{
    // if we have not loaded the hederView yet
    if (!_headerView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

- (IBAction)addNewItem:(id)sender
{
    
}

-(IBAction)toggleEditingMode:(id)sender
{
    if (self.isEditing)
    {
        // change the text to infor user of the state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // turn off editing mode
        [self setEditing:NO animated:YES];
    }
    else
    {
        // change the text to inform user of the state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        // turn on editing mode
        [self setEditing:YES animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UIView *header = [self headerView];
    [self.tableView setTableHeaderView:header];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create an instance of UITableViewCell, with default appearance
    // UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    // ste the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the table view
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

@end
