//
//  ELCImagePickerDemoViewController.m
//  TESTDUOTU
//
//  Created by fairy on 15/12/14.
//  Copyright © 2015年 fairy. All rights reserved.
//

#import "AppDelegate.h"
#import "ELCImagePickerDemoViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>


@interface ELCImagePickerDemoViewController ()

@property (nonatomic, strong) ALAssetsLibrary *specialLibrary  ;
@property (nonatomic,
           ) NSMutableArray *AllImages;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@end

@implementation ELCImagePickerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AllImages = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)choose:(id)sender {
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc]initImagePicker];
    //elcPicker.maximumImagesCount = 9;
    if (self.AllImages.count <= 9) {
        elcPicker.maximumImagesCount = 9-self.AllImages.count;
    }else elcPicker.maximumImagesCount = 0;
    elcPicker.returnsOriginalImage = YES;
    elcPicker.onOrder = YES;
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage];
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSInteger i;
    if (self.AllImages.count == 0) {
        i = 0;
    }else i = self.AllImages.count  ;
    
    
    CGRect workingFrame;// = _scrollView.frame;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
                [self.AllImages addObject:image];
                for ( NSInteger j = i ; j<self.AllImages.count; j++) {
                    
                    workingFrame = CGRectMake(10+60*(j%3), 10 + j/3* 110, 50, 100);
                   
                }
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                [imageview setContentMode:UIViewContentModeScaleAspectFit];
                imageview.frame = workingFrame;
                
                [self.view addSubview:imageview];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    
    if (self.AllImages.count >= 9) {
        [self.chooseButton removeFromSuperview];
    }
        
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)check:(id)sender {
}

- (IBAction)deleteImage:(id)sender {
    for (UIView *view in self.view.subviews) {
        if (view != self.chooseButton) {
            [view removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
