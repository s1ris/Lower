@interface SBDashBoardCombinedListViewController : UIViewController
-(void) _updateListViewContentInset;
-(void) _layoutListView;
-(UIEdgeInsets) _listViewDefaultContentInsets;
@end

@interface SBLockStateAggregator : NSObject
+(id) sharedInstance;
-(unsigned long long)lockState;
@end
