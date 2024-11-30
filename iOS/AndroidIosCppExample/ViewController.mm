#import "ViewController.h"
#import "CoreWrapper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* textFromCppCore = [CoreWrapper concatenateMyStringWithCppString:@"Obj-C++"];
    [_label setText:textFromCppCore];
    
    // Create a UIImageView and set the image
    
    UIImage *image = [CoreWrapper skBitmapToUIImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIColor *color = [UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
    imageView.backgroundColor = color;
    imageView.frame = CGRectMake(50, 50, 100, 100);  // Set the desired frame
    [self.view addSubview:imageView];  // Add the image view to the main view
}

@end
