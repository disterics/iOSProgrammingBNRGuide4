//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by disterics on 9/3/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"

#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,
                                        UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // if the device has a camera take a picture, else just pick from
    // the photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BNRItem *item = [self item];
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // use a filtered NSDate object to set the dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemKey = self.item.itemKey;
    // Get the image
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // clear first responder
    [self.view endEditing:YES];
    
    // save changes to the item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

-(void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

#pragma mark - UINavigationControllerDelegate

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get the image from the info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // store the image in the image store for the item key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    // put the image into the screen
    self.imageView.image = image;
    
    // Take the image picker off the screen -
    // we must this dismiss method
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
