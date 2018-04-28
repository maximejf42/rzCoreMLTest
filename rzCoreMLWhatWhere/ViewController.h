//
//  ViewController.h
//  rzCoreMLWhatWhere
//
//  Created by Robert Zimmelman on 7/8/17.
//  Copyright © 2017 Robert Zimmelman. All rights reserved.
//

#import "SqueezeNet.h"
#import "GoogLeNetPlaces.h"
#import "Inceptionv3.h"
#import "VGG16.h"
#import "Resnet50.h"
#import "MobileNet.h"


@import UIKit;
@import ImageIO;
@interface ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property MobileNet *myMobileNetModel;
@property SqueezeNet *mySqueezeNetModel;
@property GoogLeNetPlaces *myGoogleModel;
@property Inceptionv3 *myInceptionV3Model;
@property VGG16 *myVGG16Model;
@property Resnet50 *myResNet50Model;
@property (weak, nonatomic) IBOutlet UIButton *myAnalyzeButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *myInceptionV3Category;
@property (weak, nonatomic) IBOutlet UILabel *myGoogleNetCategory;
@property (weak, nonatomic) IBOutlet UILabel *mySqueezeNetCategory;
@property (weak, nonatomic) IBOutlet UILabel *myVGG16Category;
@property (weak, nonatomic) IBOutlet UILabel *myResNetCategory;
@property (weak, nonatomic) IBOutlet UILabel *myMobileNetCategory;

@property (weak, nonatomic) IBOutlet UILabel *myInceptionPct;
@property (weak, nonatomic) IBOutlet UILabel *myGoogleNetPct;
@property (weak, nonatomic) IBOutlet UILabel *mySqueezeNetPct;
@property (weak, nonatomic) IBOutlet UILabel *myVCC16Pct;
@property (weak, nonatomic) IBOutlet UILabel *myResNetPct;
@property (weak, nonatomic) IBOutlet UILabel *myMobileNetPct;




@property (strong,nonatomic) UIImagePickerController *myPicker;
@property (strong,nonatomic) UIImagePickerController *myCameraPicker;
@property NSString *myPlaceHolderText;

- (IBAction)myTakeAPhoto:(id)sender;

- (IBAction)myPickAnImage:(id)sender;

- (IBAction)myAnalyzeButtonWasPressed:(id)sender;


@end

