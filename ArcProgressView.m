//
//  ArcProgressView.m
//  dsasdwq
//
//  Created by 朱鑫华 on 2018/9/11.
//  Copyright © 2018年 朱鑫华. All rights reserved.
//

#import "ArcProgressView.h"

#define Radius 20.0
#define pices 4
#define colorArray @[[UIColor redColor],[UIColor greenColor],[UIColor yellowColor],[UIColor whiteColor]]

@interface  ArcProgressView()

@property (nonatomic,strong) NSMutableArray  * layers;


@property (nonatomic,assign) BOOL   animate;



@end


@implementation ArcProgressView

-(NSMutableArray *)layers{
    if (_layers == nil) {
        _layers = [NSMutableArray array];
    }
    return _layers;
}


-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}



-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        [[NSBundle mainBundle] loadNibNamed:@"ArcProgressView" owner:self options:nil];
//        [self addSubview:self.bgview];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ArcProgressView" owner:self options:nil][0];
        [self setUp];
    }
    return self;
}


- (void)setUp{
    self.backgroundColor = [UIColor grayColor];
    CGFloat preAngle = 80.0;
    CGFloat margin = (360.0 - preAngle * pices) / ( pices + 1 );
     
    for (int i = 0; i < 4; i++) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)  radius: Radius startAngle:(margin + i * (margin + preAngle))/ 180.0 * M_PI endAngle:((i+1) * (margin + preAngle))/180.0*M_PI clockwise:YES];
        [self addLayerWithColor:colorArray[i] andPath:path];
    }
    
}


- (void)addLayerWithColor:(UIColor *)color andPath:(UIBezierPath *)path {
    CAShapeLayer *redL = [CAShapeLayer layer];
    redL.strokeColor = color.CGColor;
    redL.fillColor = [UIColor clearColor].CGColor;
    redL.lineWidth = 10;
    redL.bounds = self.bounds;
    redL.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    redL.anchorPoint = CGPointMake(0.5, 0.5);
    redL.path = path.CGPath;
    [self.layer addSublayer:redL];
    [self.layers addObject:redL];
}

- (void)startAnimation{
    if (self.animate == NO) {
        for (int i = 0; i < self.layers.count; i++) {
            CAShapeLayer *layer = self.layers[i];
            CABasicAnimation *ani = [CABasicAnimation animation];
            ani.duration = 2;
            ani.keyPath = @"transform.rotation";
            ani.toValue = @(M_PI * 2 + i * M_PI );
            ani.repeatCount = MAXFLOAT;
            [layer addAnimation:ani forKey:nil];
        }
        self.animate = YES;
    }else{
        NSLog(@"动画已开始，不要多点！");
    }
    
}


+ (instancetype)arcProgressView{
    return [[NSBundle mainBundle] loadNibNamed:@"ArcProgressView" owner:self options:nil][0];
}

-(void)drawRect:(CGRect)rect{
    NSString * str = [NSString stringWithFormat:@"%.f%%",self.progress];
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : [UIColor redColor],
                           NSFontAttributeName : [UIFont systemFontOfSize:13]
                           };
   CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGRect strRect = CGRectMake((rect.size.width - size.width )* 0.5 , (rect.size.height - size.height )* 0.5 , size.width, size.height);
    [str drawInRect:strRect withAttributes:dict];
    
}



@end
