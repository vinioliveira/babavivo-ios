
#import "MenuSideViewController.h"

#import "SWRevealViewController.h"
#import "MainTableViewController.h"
#import "SideMenuViewCell.h"
#import "HeaderMenuSideCell.h"


@interface MenuSideViewController()
{
    NSInteger _presentedRow;
    NSArray * menu ;
    NSArray * icons;
}

@end

@implementation MenuSideViewController

@synthesize rearTableView = _rearTableView;


#pragma mark - View lifecycle



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menu = [NSArray arrayWithObjects: @"Header", @"Perfil", @"Refresh", @"Message", @"Settings", @"Help", nil];
    icons = [NSArray arrayWithObjects: @"Header", @"user", @"refresh", @"mail", @"gear", @"help", nil];

}


#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menu count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 150 : 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = nil;
    if(row == 0){
        cellIdentifier = @"HeaderCell";
    }else{
        cellIdentifier = @"Cell";
    }

    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (nil == cell) {
        if(row == 0){
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"HeaderMenuSideCell" owner:nil options:nil];
            for (id currentObject in nibObjects)
            {
                if ([currentObject isKindOfClass:[HeaderMenuSideCell class]])
                {
                    cell = (HeaderMenuSideCell *)currentObject;
                }
            }
        }else{
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuViewCell" owner:nil options:nil];
            for (id currentObject in nibObjects)
            {
                if ([currentObject isKindOfClass:[SideMenuViewCell class]])
                {
                    cell = (SideMenuViewCell *)currentObject;
                }
            }
        }

    }
    
    if(row == 0){
        ((HeaderMenuSideCell *) cell).avatar.image = [UIImage imageNamed:@"me_user"];
        ((HeaderMenuSideCell *) cell).name.text = @"Marcus Vinicius Oliveira";
        [cell setUserInteractionEnabled:NO];
    }else{
        ((SideMenuViewCell *) cell).text.text = NSLocalizedString( [menu objectAtIndex:row], nil);
        ;
        ((SideMenuViewCell *) cell).icon.image = [UIImage imageNamed:[icons objectAtIndex:row]];
    }
    
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    
    if ( row == _presentedRow )
    {
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    else if (row == 2)
    {
        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
        return;
    }
    else if (row == 3)
    {
        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
        return;
    }

    // otherwise we'll create a new frontViewController and push it with animation

    UIViewController *newFrontController = nil;

    if (row == 0)
    {
        newFrontController = [[MainTableViewController alloc] init];
    }
    

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:YES];
    
    _presentedRow = row;  // <- store the presented row
}
@end