//
//  ViewController.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 01/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "AllProductsController.h"
#import "CategoryWithProductsCell.h"
#import "ProductTableCell.h"
#import "CategorySectionCell.h"
#import "Category.h"

@interface AllProductsController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL isExpandedViewOn;
@property (strong, nonatomic) NSArray<Category *> *categories;
@property (strong, nonatomic) NSArray *imageCache;

@end

@implementation AllProductsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categories = [self getAllCategoriesFromJSON];
    
    self.isExpandedViewOn = YES;

    [self.tableView registerNib: [UINib nibWithNibName: @"CategoryWithProductsCell" bundle: nil] forCellReuseIdentifier: @"CategoryWithProductsCell"];
    [self.tableView registerNib: [UINib nibWithNibName: @"ProductTableCell" bundle: nil] forCellReuseIdentifier: @"ProductTableCell"];
    [self.tableView registerNib: [UINib nibWithNibName: @"CategorySectionCell" bundle: nil] forCellReuseIdentifier: @"CategorySectionCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    [self.tableView setContentInset: UIEdgeInsetsMake(8,0,0,0)];

    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:@"Expanded",@"List View",
                                             nil]];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor lightGrayColor];
    
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentedControl;
}

- (void)segmentAction:(UISegmentedControl *)segmentedControl {
    self.isExpandedViewOn = (segmentedControl.selectedSegmentIndex == 0);
    [self.tableView reloadData];
    
    if (self.isExpandedViewOn) {
        self.tableView.estimatedRowHeight = 100;
    }else {
        self.tableView.estimatedRowHeight = 40;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    if (self.isExpandedViewOn) {
        return 1;
    }
    return self.categories.count;
}


- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    if (self.isExpandedViewOn) {
        return self.categories.count;
    }
    
    if (self.categories[section].isExpanded) {
        return 1 + self.categories[section].products.count;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isExpandedViewOn) {
        CategoryWithProductsCell *cell = (CategoryWithProductsCell *)[self.tableView dequeueReusableCellWithIdentifier: @"CategoryWithProductsCell"];
        cell.category = self.categories[indexPath.row];
        return cell;
    }
    
    if (indexPath.row == 0) {
        CategorySectionCell *cell = (CategorySectionCell *)[self.tableView dequeueReusableCellWithIdentifier: @"CategorySectionCell"];
        cell.category = self.categories[indexPath.section];
        return cell;
    }
    
    ProductTableCell *cell = (ProductTableCell *)[self.tableView dequeueReusableCellWithIdentifier: @"ProductTableCell"];
    cell.product = self.categories[indexPath.section].products[indexPath.row - 1];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isExpandedViewOn) {
        return;
    }
    
    if (indexPath.row == 0) {
        if (self.categories[indexPath.section].isExpanded) {
            self.categories[indexPath.section].isExpanded = NO;
        } else {
            if (indexPath.row == 0) {
                for (Category *category in self.categories) {
                    category.isExpanded = NO;
                }
                self.categories[indexPath.section].isExpanded = YES;
            }
        }
        
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        
    }
}

- (NSArray<Category *> *)getAllCategoriesFromJSON {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Input" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *categories = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return [Category getCategoriesFromJSON: categories];
}



@end
