//
//  ViewController.m
//  rzCoreMLWhatWhere
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
@synthesize myInceptionLabel;
@synthesize myGoogleNetLabel;
@synthesize mySqueezeNetLabel;
@synthesize myVCC16Label;
@synthesize myResNetLabel;
@synthesize myMobileNetLabel;

float myIV3Pct;
float mySNPct;
float myGNPct;
float myVGNPct;
float myRNPct;
float myMNPct;



bool myWelcomeMessageWasShownOnce = false;

-(void)viewWillAppear:(BOOL)animated{
    mySqueezeNetModel = [[SqueezeNet alloc] init];
    myGoogleModel = [[GoogLeNetPlaces alloc] init];
    myInceptionV3Model = [[Inceptionv3 alloc] init];
    myVGG16Model = [[VGG16 alloc] init];
    myResNet50Model = [[Resnet50 alloc] init];
    myMobileNetModel = [[MobileNet alloc] init];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//        [myActivityIndicator startAnimating];
    if (myWelcomeMessageWasShownOnce) {
        return;
    } else {
        [self myAnalyzeButtonWasPressed:self];
        [self myShowWelcomeMessage];
        myWelcomeMessageWasShownOnce = true;
    }
}


//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [myActivityIndicator stopAnimating];
//}

- (void)myStartAnimating{
//    [myActivityIndicator setHidden:false];
    [myActivityIndicator startAnimating];
}


- (IBAction)mySetupTheView {
//    myActivityIndicator = [self.view viewWithTag:101];
//    [myActivityIndicator setHidden:false];
//    [myActivityIndicator stopAnimating];
    [self myClearTheLabels];
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

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue{
    [myActivityIndicator stopAnimating];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"segue returned here");
}


- (void)myAnalyzeTheImage{
    [self myClearTheLabels];
    CVPixelBufferRef myInceptionV3PixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:299.0];
    Inceptionv3Output *myInceptionV3Output = [myInceptionV3Model predictionFromImage:myInceptionV3PixelBufferRef error:nil];
    myIV3Pct = ([[myInceptionV3Output.classLabelProbs valueForKey:myInceptionV3Output.classLabel] floatValue]*100.0);
    [myInceptionV3Category setText:myInceptionV3Output.classLabel];
    [myInceptionPct setText:[NSString stringWithFormat:@" has %2.0f%% confidence that it's a",myIV3Pct]];

    [myInceptionLabel setTextColor:UIColor.yellowColor];
    [myInceptionPct setTextColor:UIColor.yellowColor];
    [myInceptionV3Category setTextColor:UIColor.yellowColor];
    if (myIV3Pct < 30.0 ) {
        [myInceptionLabel setTextColor:UIColor.redColor];
        [myInceptionPct setTextColor:UIColor.redColor];
        [myInceptionV3Category setTextColor:UIColor.redColor];
    }
    if (myIV3Pct > 80.0 ) {
        [myInceptionLabel setTextColor:UIColor.greenColor];
        [myInceptionPct setTextColor:UIColor.greenColor];
        [myInceptionV3Category setTextColor:UIColor.greenColor];
    }
    
    
    
    
    
    CVPixelBufferRef mySqueezeNetPixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:227.0];
    SqueezeNetOutput *mySqueezeNetModelOutput = [mySqueezeNetModel predictionFromImage:mySqueezeNetPixelBufferRef error:nil];
    
    mySNPct = ([[mySqueezeNetModelOutput.classLabelProbs valueForKey:mySqueezeNetModelOutput.classLabel] floatValue]*100.0);
    [mySqueezeNetCategory setText:mySqueezeNetModelOutput.classLabel];
    [mySqueezeNetPct setText:[NSString stringWithFormat:@" has %2.0f%% confidence that it's a",mySNPct]];
    
    [mySqueezeNetLabel setTextColor:UIColor.yellowColor];
    [mySqueezeNetPct setTextColor:UIColor.yellowColor];
    [mySqueezeNetCategory setTextColor:UIColor.yellowColor];

    if (mySNPct < 30.0 ) {
        [mySqueezeNetPct setTextColor:UIColor.redColor];
        [mySqueezeNetCategory setTextColor:UIColor.redColor];
        [mySqueezeNetLabel setTextColor:UIColor.redColor];
    }
    if (mySNPct > 80.0 ) {
        [mySqueezeNetPct setTextColor:UIColor.greenColor];
        [mySqueezeNetCategory setTextColor:UIColor.greenColor];
        [mySqueezeNetLabel setTextColor:UIColor.greenColor];
    }

    
    
    
    
    
    CVPixelBufferRef myGoogleNetPlacesPixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    GoogLeNetPlacesOutput *myGoogleNetPlacesOutput = [myGoogleModel predictionFromSceneImage:myGoogleNetPlacesPixelBufferRef error:nil];
    myGNPct = ([[myGoogleNetPlacesOutput.sceneLabelProbs valueForKey:myGoogleNetPlacesOutput.sceneLabel] floatValue]*100.0);
    [myGoogleNetCategory setText:myGoogleNetPlacesOutput.sceneLabel];
    [myGoogleNetPct setText:[NSString stringWithFormat:@" has %2.0f%% confidence it's a",myGNPct]];
    
    [myGoogleNetLabel setTextColor:UIColor.yellowColor];
    [myGoogleNetPct setTextColor:UIColor.yellowColor];
    [myGoogleNetCategory setTextColor:UIColor.yellowColor];

    if (myGNPct < 30.0 ) {
        [myGoogleNetLabel setTextColor:UIColor.redColor];
        [myGoogleNetPct setTextColor:UIColor.redColor];
        [myGoogleNetCategory setTextColor:UIColor.redColor];
    }

    if (myGNPct > 80.0 ) {
        [myGoogleNetLabel setTextColor:UIColor.greenColor];
        [myGoogleNetPct setTextColor:UIColor.greenColor];
        [myGoogleNetCategory setTextColor:UIColor.greenColor];
    }

    

    
    
    
    
    CVPixelBufferRef myVGG16PixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    VGG16Output *myVgg16Output = [myVGG16Model predictionFromImage:myVGG16PixelBufferRef error:nil];
    myVGNPct = ([[myVgg16Output.classLabelProbs valueForKey:myVgg16Output.classLabel] floatValue]*100.0);
    [myVGG16Category setText:myVgg16Output.classLabel];
    [myVCC16Pct setText:[NSString stringWithFormat:@" has %2.0f%% confidence it's a",myVGNPct]];
    
    
    [myVCC16Label setTextColor:UIColor.yellowColor];
    [myVCC16Pct setTextColor:UIColor.yellowColor];
    [myVGG16Category setTextColor:UIColor.yellowColor];

    if (myVGNPct < 30.0 ) {
        [myVCC16Label setTextColor:UIColor.redColor];
        [myVCC16Pct setTextColor:UIColor.redColor];
        [myVGG16Category setTextColor:UIColor.redColor];
    }
    if (myVGNPct > 80.0 ) {
        [myVCC16Label setTextColor:UIColor.greenColor];
        [myVCC16Pct setTextColor:UIColor.greenColor];
        [myVGG16Category setTextColor:UIColor.greenColor];
    }

    
    
    
    
    CVPixelBufferRef myResNet50PixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    Resnet50Output *myResNet50Output = [myResNet50Model predictionFromImage:myResNet50PixelBufferRef error:nil];
    myRNPct = ([[myResNet50Output.classLabelProbs valueForKey:myResNet50Output.classLabel] floatValue]*100.0);
    [myResNetCategory setText:myResNet50Output.classLabel];
    [myResNetPct setText:[NSString stringWithFormat:@" has %2.0f%% confidence it's a",myRNPct]];
    
    [myResNetLabel setTextColor:UIColor.yellowColor];
    [myResNetPct setTextColor:UIColor.yellowColor];
    [myResNetCategory setTextColor:UIColor.yellowColor];

    if (myRNPct < 30.0 ) {
        [myResNetLabel setTextColor:UIColor.redColor];
        [myResNetPct setTextColor:UIColor.redColor];
        [myResNetCategory setTextColor:UIColor.redColor];
    }

    if (myRNPct > 80.0 ) {
        [myResNetLabel setTextColor:UIColor.greenColor];
        [myResNetPct setTextColor:UIColor.greenColor];
        [myResNetCategory setTextColor:UIColor.greenColor];
    }
    
    
    
    
    
    CVPixelBufferRef myMobileNetPixelBufferRef = [self myMakePixelBufferWithImage:myImage.image ofSize:224.0];
    MobileNetOutput *myMobileNetOutput = [myMobileNetModel predictionFromImage:myMobileNetPixelBufferRef error:nil];
    myMNPct = ([[myMobileNetOutput.classLabelProbs valueForKey:myMobileNetOutput.classLabel] floatValue]*100.0);
    [myMobileNetCategory setText:myMobileNetOutput.classLabel];
    [myMobileNetPct setText:[NSString stringWithFormat:@" has %2.0f%% confidence it's a",myMNPct]];
    
    [myMobileNetLabel setTextColor:UIColor.yellowColor];
    [myMobileNetPct setTextColor:UIColor.yellowColor];
    [myMobileNetCategory setTextColor:UIColor.yellowColor];

    if (myMNPct < 30.0 ) {
        [myMobileNetLabel setTextColor:UIColor.redColor];
        [myMobileNetPct setTextColor:UIColor.redColor];
        [myMobileNetCategory setTextColor:UIColor.redColor];
    }

    if (myMNPct > 80.0 ) {
        [myMobileNetLabel setTextColor:UIColor.greenColor];
        [myMobileNetPct setTextColor:UIColor.greenColor];
        [myMobileNetCategory setTextColor:UIColor.greenColor];

    }

    
    
    
}

- (IBAction)myTakeAPhoto:(id)sender {
    [self myClearTheLabels];
    [myActivityIndicator startAnimating];
    bool myTest1 = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    myCameraPicker = [[ UIImagePickerController alloc] init];
    myCameraPicker.delegate = self;
    myCameraPicker.allowsEditing = YES;
    if (myTest1) {
        [myCameraPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:myCameraPicker animated:YES completion:nil];
    }
    else {
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"No Camera" message:@"This device has no camera or the camera is disabled.  Select images from the Photo Library." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *myAlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.myCameraPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:self.myCameraPicker animated:YES completion:nil];
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

- (IBAction)myAnalyzeButtonWasPressed:(id)sender {
//    [self mySetupTheView];
//    [myActivityIndicator setTintColor:[UIColor redColor]];
//    [self myClearTheLabels];
    [self performSelectorOnMainThread:@selector(myClearTheLabels) withObject:self waitUntilDone:true];
    [self performSelectorOnMainThread:@selector(myStartAnimating) withObject:myActivityIndicator waitUntilDone:true];
//    myActivityIndicator = [self.view viewWithTag:101];
//    [myActivityIndicator startAnimating];
    NSLog(@"analysis starts");
    [self myAnalyzeTheImage];
    NSLog(@"analysis ends");
    NSLog(@"animating  %d",myActivityIndicator.isAnimating);
    [myActivityIndicator stopAnimating];
//    [myActivityIndicator stopAnimating];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    myImage.image = [ info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.myActivityIndicator stopAnimating];
        [self myAnalyzeButtonWasPressed:self];
    }];
}


-(void) myShowWelcomeMessage {
    UIAlertController *myWelcomeAlertController = [UIAlertController alertControllerWithTitle:@"Hi There!!!" message:@"This  Little App lets you use Photos or your camera to take a look the latest advance in computing, Machine Learning!!  Thanks to Apple's great simple toolkit, CoreML, we can build apps that use Artificial Intelligence and Machine Learning with little effort.   Select images from the Photo Library or use your camera.  If you use your camera, no images will be saved.  If you are developer, grab the source code for this app on github/robzim." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *myAlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self myClearTheLabels];
        [self myAnalyzeButtonWasPressed:self];
    }];
    [myWelcomeAlertController addAction:myAlertAction];
    [self presentViewController:myWelcomeAlertController animated:YES completion:^{
        NSLog(@"showed the welcome message");
    } ];
}




- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [ picker dismissViewControllerAnimated:YES completion:nil];
    [myActivityIndicator stopAnimating];
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
