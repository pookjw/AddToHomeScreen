//
//  ViewController.m
//  MyApp
//
//  Created by Jinwoo Kim on 12/27/23.
//

#import "ViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <WebKit/WebKit.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@interface ViewController ()
@property (retain, nonatomic) IBOutlet WKWebView *webView;
@end

@implementation ViewController

- (void)dealloc {
    [_webView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.apple.com"]];
    [_webView loadRequest:request];
    [request release];
}

- (IBAction)method_1:(id)sender {
    // Do not use _SFWebClipViewController.
    __block typeof(self) unretained = self;
    UIViewController *vc = ((id (*)(id, SEL, id, id))objc_msgSend)([NSClassFromString(@"SFAddToHomeScreenViewController") alloc],
                                                                   NSSelectorFromString(@"initWithWebView:completion:"),
                                                                   self.webView,
                                                                   ^{
        [unretained.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    });

    [self presentViewController:vc animated:YES completion:nil];
    
    [vc release];
}

- (IBAction)method_2:(UIBarButtonItem *)sender {
    __kindof UIActivity *activity = ((id (*)(id, SEL, id))objc_msgSend)([NSClassFromString(@"_SFAddToHomeScreenActivity") alloc], NSSelectorFromString(@"initWithWebView:"), self.webView);
    
    // not necessary
    NSExtensionItem *item = [NSExtensionItem new];
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithItem:_webView.URL typeIdentifier:UTTypeURL.identifier];
    item.userInfo = @{
        NSExtensionItemAttachmentsKey: @[itemProvider],
        @"com.apple.UIKit.NSExtensionItemUserInfoIsContentManagedKey": @NO,
        @"supportsJavaScript": @YES
    };
    [itemProvider release];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[item, _webView.URL] applicationActivities:@[activity]];
    
    [activity release];
    [item release];
    
    vc.popoverPresentationController.barButtonItem = sender;
    
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
}

@end
