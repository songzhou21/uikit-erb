require 'erb'

view_name = ARGV[0]

interface = ERB.new <<-END
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface <%= view_name %>ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
END


imp = ERB.new <<-END
#import "<%= view_name %>ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface <%= view_name %>View : UIView

@end

@implementation <%= view_name %>View 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end

@interface <%= view_name %>ViewController ()

@property (nonatomic) <%= view_name %>View *view;

@end

@implementation <%= view_name %>ViewController

@dynamic view;
- (void)loadView {
    self.view = [<%= view_name %>View new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

NS_ASSUME_NONNULL_END
END

open("#{view_name}ViewController.h", "w") { |out|
    out.puts interface.result(binding)
}

open("#{view_name}ViewController.m", "w") { |out|
    out.puts imp.result(binding)
}
