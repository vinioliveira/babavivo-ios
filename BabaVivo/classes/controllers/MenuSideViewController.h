#import <UIKit/UIKit.h>
@interface MenuSideViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) IBOutlet UITableView *rearTableView;
@end