@interface UITableViewLabel: UILabel
@property (nonatomic) UITableViewCell *tableCell;
@end

@interface PSSpecifier : NSObject
@property (nonatomic,retain) NSString * identifier;
@end

@interface PSTableCell: UITableViewCell
@property (nonatomic,retain) PSSpecifier * specifier;
@end

@interface _UINavigationBarLargeTitleView : UIView
@end

@interface UIView (CL)
- (id)_viewControllerForAncestor;
- (void)setOverrideUserInterfaceStyle:(NSInteger)style;
@end

%hook PSTableCell
- (void)layoutSubviews {
    %orig;
    if ([[self _viewControllerForAncestor] isKindOfClass:%c(PSUIPrefsListController)]) {
        UITableViewLabel *title = MSHookIvar<UITableViewLabel *>(self, "_textLabel");
        UITableViewLabel *detail = MSHookIvar<UITableViewLabel *>(self, "_detailTextLabel");
        UIImageView *imageView = MSHookIvar<UIImageView *>(self, "_imageView");
        if ([NSStringFromClass([self class]) isEqualToString:@"PSUIAppleAccountCell"]) {
            title.hidden = YES;
            detail.hidden = YES;
            imageView.center = CGPointMake(self.center.x, imageView.center.y);
        } else {
            title.center = CGPointMake(self.center.x, title.center.y);
        }
        if ([self.specifier.identifier isEqual:@"WIFI"]) {
            detail.font = [UIFont boldSystemFontOfSize:10];
        }
    }
}
%end

%hook _UINavigationBarLargeTitleView
- (void)layoutSubviews {
    %orig;
    for (UILabel *label in self.subviews) {
        if ([label.text isEqual:@"Settings"]) {
        label.center = CGPointMake(self.center.x, label.center.y);
        }
    }
}
%end
