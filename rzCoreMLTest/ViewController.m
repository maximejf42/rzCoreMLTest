//
//  ViewController.m
//  rzCoreMLTest
//
//  Created by Robert Zimmelman on 7/8/17.
//  Copyright © 2017 Robert Zimmelman. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize mySqueezeNetModel;
@synthesize myGoogleModel;
@synthesize myInceptionV3Model;
@synthesize myVGG16Model;
@synthesize myResNet50Model;
@synthesize myMobileNetModel;
@synthesize myImage;
@synthesize myPicker;
@synthesize myCameraPicker;
@synthesize myInceptionV3Category;
@synthesize mySqueezeNetCategory;
@synthesize myGoogleNetCategory;
@synthesize myVGG16Category;
@synthesize myResNetCategory;
@synthesize myMobileNetCategory;
@synthesize myActivityIndicator;
@synthesize myPlaceHolderText;
@synthesize myAnalyzeButton;
@synthesize myInceptionPct;
@synthesize myGoogleNetPct;
@synthesize myVCC16Pct;
@synthesize myResNetPct;
@synthesize myMobileNetPct;
@synthesize mySqueezeNetPct;
float myIV3Pct;
float mySNPct;
float myGNPct;
float myVGNPct;
float myRNPct;
float myMNPct;


//-(void)viewWillAppear:(BOOL)animated{
//    [myActivityIndicator startAnimating];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    mySqueezeNetModel = [[SqueezeNet alloc] init];
    myGoogleModel = [[GoogLeNetPlaces alloc] init];
    myInceptionV3Model = [[Inceptionv3 alloc] init];
    myVGG16Model = [[VGG16 alloc] init];
    myResNet50Model = [[Resnet50 alloc] init];
    myMobileNetModel = [[MobileNet alloc] init];
    [self myClearTheLabels];

    
    // Do any additional setup after loading the view, typically from a nib.
    [self myAnalyzeTheImage];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)myClearTheLabels{
    myPlaceHolderText = @" ";
    [myInceptionV3Category setText:myPlaceHolderText];
    [myGoogleNetCategory setText:myPlaceHolderText];
    [mySqueezeNetCategory setText:myPlaceHolderText];
    [myResNetCategory setText:myPlaceHolderText];
    [myMobileNetCategory setText:myPlaceHolderText];
    [myVGG16Category setText:myPlaceHolderText];
    [myInceptionPct setText:myPlaceHolderText];
    [mySqueezeNetPct setText:myPlaceHolderText];
    [myGoogleNetPct setText:myPlaceHolderText];
    [myVCC16Pct setText:myPlaceHolderText];
    [myResNetPct setText:myPlaceHolderText];
    [myMobileNetPct setText:myPlaceHolderText];

}


- (void)myAnalyzeTheImage{

    [self myClearTheLabels];

    CVPixelBufferRef myInceptionV3PixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:299.0];
    Inceptionv3Output *myInceptionV3Output = [myInceptionV3Model predictionFromImage:myInceptionV3PixelBufferRef error:nil];
    myIV3Pct = ([[myInceptionV3Output.classLabelProbs valueForKey:myInceptionV3Output.classLabel] floatValue]*100.0);
    [myInceptionV3Category setText:myInceptionV3Output.classLabel];
    [myInceptionPct setText:[NSString stringWithFormat:@" %2.0f%% sure it's a",myIV3Pct]];

    
    
    CVPixelBufferRef mySqueezeNetPixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:227.0];
    SqueezeNetOutput *mySqueezeNetModelOutput = [mySqueezeNetModel predictionFromImage:mySqueezeNetPixelBufferRef error:nil];
    mySNPct = ([[mySqueezeNetModelOutput.classLabelProbs valueForKey:mySqueezeNetModelOutput.classLabel] floatValue]*100.0);
    [mySqueezeNetCategory setText:mySqueezeNetModelOutput.classLabel];
    [mySqueezeNetPct setText:[NSString stringWithFormat:@" %2.0f%% sure it's a",mySNPct]];

    
    
    CVPixelBufferRef myGoogleNetPlacesPixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    GoogLeNetPlacesOutput *myGoogleNetPlacesOutput = [myGoogleModel predictionFromSceneImage:myGoogleNetPlacesPixelBufferRef error:nil];
    myGNPct = ([[myGoogleNetPlacesOutput.sceneLabelProbs valueForKey:myGoogleNetPlacesOutput.sceneLabel] floatValue]*100.0);
    [myGoogleNetCategory setText:myGoogleNetPlacesOutput.sceneLabel];
    [myGoogleNetPct setText:[NSString stringWithFormat:@" %2.0f%% sure it's a",myGNPct]];

    
    
    CVPixelBufferRef myVGG16PixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    VGG16Output *myVgg16Output = [myVGG16Model predictionFromImage:myVGG16PixelBufferRef error:nil];
    myVGNPct = ([[myVgg16Output.classLabelProbs valueForKey:myVgg16Output.classLabel] floatValue]*100.0);
    [myVGG16Category setText:myVgg16Output.classLabel];
    [myVCC16Pct setText:[NSString stringWithFormat:@" %2.0f%% sure it's a",myVGNPct]];

    
    
    CVPixelBufferRef myResNet50PixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    Resnet50Output *myResNet50Output = [myResNet50Model predictionFromImage:myResNet50PixelBufferRef error:nil];
    myRNPct = ([[myResNet50Output.classLabelProbs valueForKey:myResNet50Output.classLabel] floatValue]*100.0);
    [myResNetCategory setText:myResNet50Output.classLabel];
    [myResNetPct setText:[NSString stringWithFormat:@" %2.0f%% sure it's a",myRNPct]];
    
    
    CVPixelBufferRef myMobileNetPixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    MobileNetOutput *myMobileNetOutput = [myMobileNetModel predictionFromImage:myMobileNetPixelBufferRef error:nil];
    myMNPct = ([[myMobileNetOutput.classLabelProbs valueForKey:myMobileNetOutput.classLabel] floatValue]*100.0);
    [myMobileNetCategory setText:myMobileNetOutput.classLabel];
    [myMobileNetPct setText:[NSString stringWithFormat:@" %2.0f%% sure it's a",myMNPct]];
    
}

- (IBAction)myTakeAPhoto:(id)sender {
    [self myClearTheLabels];

    [myActivityIndicator startAnimating];
    bool myTest1 = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    myCameraPicker = [[ UIImagePickerController alloc] init];
    myCameraPicker.delegate = self;
    myCameraPicker.allowsEditing = YES;
    //    NSLog(@"before camera avail check");
    if (myTest1) {
        //        NSLog(@"setting to camera");
        [myCameraPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:myCameraPicker animated:YES completion:nil];
    }
    else {
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"No Camera" message:@"This device has no camera or the camera is disabled.  Select images from the Photo Library." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *myAlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //        NSLog(@"setting to photo library");
            [myCameraPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:myCameraPicker animated:YES completion:nil];
        }];
        [myAlertController addAction:myAlertAction];
        [self presentViewController:myAlertController animated:YES completion:nil ];
    }
}

- (IBAction)myPickAnImage:(id)sender {
    [self myClearTheLabels];
    [myActivityIndicator startAnimating];
    myPicker = [[ UIImagePickerController alloc] init];
    [myPicker setDelegate:self];
    [myPicker setAllowsEditing:YES];
    [myPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:myPicker animated:YES completion:nil];
}

- (IBAction)myAnalyze:(id)sender {
    [self myClearTheLabels];

    NSLog(@"%@",[myAnalyzeButton valueForKeyPath:@"highlighted"] );
    [myActivityIndicator startAnimating];
    [self myAnalyzeTheImage];
    [myActivityIndicator stopAnimating];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    myImage.image = [ info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [myActivityIndicator stopAnimating];
        [self myAnalyzeTheImage];
    }];
}






- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [ picker dismissViewControllerAnimated:YES completion:nil];
}

//
//
//
//    rz
//   setting prefersStatusBarHidden makes the top of the screen (status bar) hidden so the buttons work all
//    the way to the top of the screen
//
- (BOOL)prefersStatusBarHidden {
    return YES;
}








-(CVPixelBufferRef) myMakePixelBufferWithImage: (UIImage *) theImage ofSize: (float)theSize {
    CIContext *myGlobalContext = [CIContext contextWithOptions:nil];
    CIImage *myHoldingImage = [[CIImage alloc] initWithImage:theImage];
    CIImage *myStartingImage = [[CIImage alloc] init];
    float myXScale = theSize / theImage.size.width;
    float myYScale = theSize / theImage.size.height;
    myStartingImage = [myHoldingImage imageByApplyingTransform:CGAffineTransformMakeScale(myXScale, myYScale)];
    [myGlobalContext createCGImage:myStartingImage fromRect:myStartingImage.extent];
    [myGlobalContext createCGImage:myHoldingImage fromRect:myHoldingImage.extent];
    CVPixelBufferRef myPixelBuffer;
    CVReturn myreturn = CVPixelBufferCreate(NULL, theSize, theSize, kCVPixelFormatType_32BGRA, nil, &myPixelBuffer);
    [myGlobalContext render:myStartingImage   toCVPixelBuffer:myPixelBuffer];
    if (myreturn) {
        NSLog(@"Error!!");
    }
    return myPixelBuffer;
}


@end
