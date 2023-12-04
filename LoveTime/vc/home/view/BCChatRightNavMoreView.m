
#import "BCChatRightNavMoreView.h"
#import <Masonry/Masonry.h>
#import <QMUIKit/QMUIKit.h>
#import "UIView+RoundedCorners.h"
#import "LoveTime-Swift.h"



@interface BCChatRightNavMoreView ()

//@property (nonatomic, strong) UIImageView * arrowImgView ;
@property (nonatomic, strong) UIImageView * BgImgView ; //Background Image
@property (nonatomic, strong) NSArray * itemNameArr ; //
@property (nonatomic, strong) NSArray * itemImageStrArr ; //

@property (nonatomic, strong) UIButton * closeBtn ; // 

@end


@implementation BCChatRightNavMoreView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    self.backgroundColor = [UIColor clearColor];

    self.closeBtn = [[UIButton alloc]init];
    [self.closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.closeBtn];
    self.closeBtn.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.1];

    self.BgImgView = [[UIImageView alloc]init];
    self.BgImgView.backgroundColor = [UIColor whiteColor];
    self.BgImgView.userInteractionEnabled = YES;
    self.BgImgView.layer.cornerRadius = 10;
    self.BgImgView.layer.masksToBounds = YES;
    
    [self addSubview:self.BgImgView];
}

-(void)initUIWithItemNameArr:(NSArray *)itemNameArr ItemImageStrArr:(NSArray *)itemImageStrArr {
    _itemNameArr = itemNameArr;
    _itemImageStrArr = itemImageStrArr;
    
    [self.BgImgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
        
    CGFloat itemHeight = 55.0;
    CGFloat itemWitdh = 200;
    CGFloat itemTopMargin = 4.0;

    __weak __typeof(self)weakSelf = self;
    for (int i=0; i<_itemNameArr.count; i++) {
        BCMoreItemView * itemView = [[BCMoreItemView alloc]initWithFrame:CGRectMake(0, itemHeight * i + itemTopMargin, itemWitdh, itemHeight)];
        itemView.userInteractionEnabled =YES;
        itemView.backgroundColor = [UIColor clearColor];
        itemView.lineView.hidden = YES;
        itemView.titleImgView.image = [UIImage imageNamed:_itemImageStrArr[i]];

        itemView.title.font = [UIFont systemFontOfSize: 15.0];
        itemView.title.text = _itemNameArr[i];
        itemView.tapItem = ^{
            if (weakSelf.tapNumItem) {
                weakSelf.tapNumItem(i);
            }
               [weakSelf close];
        };
        [self.BgImgView addSubview:itemView];
        
        
        if (i == 0) {
            itemView.layer.cornerRadius = self.BgImgView.layer.cornerRadius;
            itemView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
        } else if (i == _itemNameArr.count - 1) {
            itemView.layer.cornerRadius = self.BgImgView.layer.cornerRadius;
            itemView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
        }
    }
    
    self.BgImgView.frame = CGRectMake(SCREEN_WIDTH - itemWitdh - 14.5, [UIDevice YH_Nav_Height] - 4, itemWitdh, itemHeight *_itemNameArr.count + itemTopMargin*2);

    self.BgImgView.layer.shadowRadius = 4.0;
    self.BgImgView.clipsToBounds = NO;

}


-(void)close{
    
    CFTimeInterval duration = 0.2;
    [self.BgImgView hideBasicAnimation:duration];

    [UIView animateWithDuration:duration animations:^{
        self.BgImgView.alpha = 0.0f;
        self.closeBtn.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self.BgImgView.layer removeAllAnimations];
        [self removeFromSuperview];
    }];
}

+ (void)closeFromeView:(UIView *)view {
    [view.subviews.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            [obj removeFromSuperview];
        }
    }];
}

//Step 2: Rewrite layoutSubviews, sub-control set frame
- (void)layoutSubviews {
    [super layoutSubviews];

    [self.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)showView {
    
    CFTimeInterval duration = 0.3;
    self.closeBtn.alpha = 0.0f;
    [self.BgImgView showBasicAnimation:duration corner: ShowBasicAnimationCornerTopRight];

    [UIView animateWithDuration:duration animations:^{
        self.closeBtn.alpha = 1.0f;
    }];
}

@end




@interface BCMoreItemView ()


@end

@implementation BCMoreItemView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.titleImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self addSubview:self.titleImgView];
    
    self.title = [[UILabel alloc]init];
    self.title.textColor = [UIColor whiteColor];
    self.title.textColor = [UIColor qmui_colorWithHexString:@"#0D1324"];
    self.title.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.title];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = UIColor.redColor;
    self.lineView.hidden = NO;
    [self addSubview:self.lineView];
    
    self.btn = [[UIButton alloc]init];
    [self.btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.btn addTarget:self action:@selector(btnTouch) forControlEvents:UIControlEventTouchDown];
    [self.btn addTarget:self action:@selector(btnTouchOut) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:self.btn];
    
}

-(void)btnTouch{
    self.backgroundColor = [UIColor qmui_colorWithHexString:@"#E2E4EB"];
}

-(void)btnTouchOut{
    self.backgroundColor = [UIColor clearColor];
}


-(void)btnPressed{

    self.backgroundColor = [UIColor clearColor];
    
       if (self.tapItem) {
           self.tapItem();
    }
}

//Step 2: Rewrite layoutSubviews, sub-control set frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(16);
        make.width.height.mas_equalTo(22);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.titleImgView.mas_right).mas_equalTo(14);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-20);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.titleImgView.mas_right).mas_equalTo(14);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

@end
