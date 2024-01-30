

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^TapNumItem)(int);

@interface BCChatRightNavMoreView : UIView

@property (nonatomic, copy) TapNumItem  tapNumItem ;

-(void)initUIWithItemNameArr:(NSArray *)itemNameArr ItemImageStrArr:(NSArray *)itemImageStrArr ;
+ (void)closeFromeView:(UIView *)view;

- (void)showView;

@end



typedef void(^TapItem)(void);

@interface BCMoreItemView : UIView

@property (nonatomic, strong) UIImageView * titleImgView ; //Image
@property (nonatomic, strong) UILabel * title ; //Image
@property (nonatomic, strong) UIButton * btn ; //btn

@property (nonatomic, copy) TapItem  tapItem ;

@property (nonatomic, strong) UIView * lineView ; //lineView
@end


NS_ASSUME_NONNULL_END
