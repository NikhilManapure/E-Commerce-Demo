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
#import "ProductDetailController.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
    [self configureTableView];
    [self addSegmentControl];
}

- (void) scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset {
    [self.navigationController setNavigationBarHidden: (velocity.y > 0 && self.isExpandedViewOn) animated:YES];
}

- (void)configureTableView {
    [self.tableView registerNib: [UINib nibWithNibName: @"CategoryWithProductsCell" bundle: nil] forCellReuseIdentifier: @"CategoryWithProductsCell"];
    [self.tableView registerNib: [UINib nibWithNibName: @"ProductTableCell" bundle: nil] forCellReuseIdentifier: @"ProductTableCell"];
    [self.tableView registerNib: [UINib nibWithNibName: @"CategorySectionCell" bundle: nil] forCellReuseIdentifier: @"CategorySectionCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    [self.tableView setContentInset: UIEdgeInsetsMake(8,0,0,0)];
}

- (void)addSegmentControl {
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems: [NSArray arrayWithObjects:@"Expanded",@"List View", nil]];
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
        cell.delegate = self;
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
        [self performSegueWithIdentifier:@"ToProductDetailAnimated" sender:self.categories[indexPath.section].products[indexPath.row - 1]];
    }
}

- (NSArray<Category *> *)getAllCategoriesFromJSON {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Input" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *categories = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return [Category getCategoriesFromJSON: categories];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ToProductDetail"] || [[segue identifier] isEqualToString:@"ToProductDetailAnimated"]) {
        ProductDetailController *detailViewController = [segue destinationViewController];
        detailViewController.product = (Product *)sender;
    }
}

- (void)selectProduct:(Product *)product withFrame:(CGRect)cellFrameInSuperview {
    [self.view setUserInteractionEnabled: NO];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cellFrameInSuperview];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString: product.imageUrl] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    [self.view addSubview:imageView];
    
    CGRect fullScreenRect = [UIScreen.mainScreen bounds];
    CGFloat nonViewHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    fullScreenRect.origin.y = fullScreenRect.origin.y + nonViewHeight;
    fullScreenRect.size.height = fullScreenRect.size.height - nonViewHeight;
    
    [UIView animateWithDuration: 0.2 delay: 0 options: UIViewAnimationOptionCurveLinear  animations:^{
        [imageView setFrame: fullScreenRect];
        [imageView setBackgroundColor:[UIColor whiteColor]];
        [self navigationController].navigationBar.alpha = 0.2f;
    } completion:^(BOOL finished) {
        [self.view setUserInteractionEnabled: YES];
        [UIView animateWithDuration: 0.3 delay: 0 options: UIViewAnimationOptionCurveLinear  animations:^{
            [self navigationController].navigationBar.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [self navigationController].navigationBar.alpha = 1.0f;
        }];
        [self performSegueWithIdentifier:@"ToProductDetail" sender: product];
        [imageView removeFromSuperview];
    }];
}

@end
