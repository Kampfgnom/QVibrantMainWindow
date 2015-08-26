#include "mainwindow.h"
#include "ui_mainwindow.h"

#import <AppKit/AppKit.h>

#include <QMacCocoaViewContainer>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);


    setAttribute(Qt::WA_NoSystemBackground);
    setAttribute(Qt::WA_TranslucentBackground);
//    setAttribute(Qt::WA_PaintOnScreen);

//    setAttribute(Qt::WA_TransparentForMouseEvents);

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    ui->listWidget->setAttribute(Qt::WA_MacShowFocusRect, false);

    NSView *nsview = (NSView *)winId();
    NSWindow *nswindow = [nsview window];
    nswindow.styleMask = nswindow.styleMask | NSFullSizeContentViewWindowMask;
    nswindow.titleVisibility = NSWindowTitleHidden;
    nswindow.titlebarAppearsTransparent = YES;
//    nswindow.appearance = [NSAppearance appearanceNamed:NSAppearanceNameLightContent];
    //Native setup
    static const NSRect frameRect = {
    { 0.0, 0.0 }
    ,
    { width(), height() }
    };

    int titleBarHeight = 28;
    int _trafficLightButtonsLeftMargin = 10;

    NSVisualEffectView * vibrant = [[NSVisualEffectView alloc] initWithFrame:frameRect];
    vibrant.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    vibrant.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
    [vibrant setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];

    QMacCocoaViewContainer *container = new QMacCocoaViewContainer(vibrant, this);
    QHBoxLayout *l = new QHBoxLayout(container);
    container->setLayout(l);
    ui->frameLeft->layout()->addWidget(container);
    ui->frameLeft->layout()->removeWidget(ui->frameLeftContents);
    l->addWidget(ui->frameLeftContents);

    setAutoFillBackground(false);
//    [nsview addSubview:vibrant positioned:NSWindowBelow relativeTo:nil];

//    [[[nswindow standardWindowButton:NSWindowCloseButton] superview] setAlphaValue:0];

//    nswindow.titlebarAppearsTransparent = true;
//    nswindow.movableByWindowBackground  = true;

//    [nswindow setStyleMask:NSBorderlessWindowMask];


    vibrant = [[NSVisualEffectView alloc] initWithFrame:frameRect];
    vibrant.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    vibrant.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    [vibrant setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];

    container = new QMacCocoaViewContainer(vibrant, this);
    l = new QHBoxLayout(container);
    container->setLayout(l);
    ui->frameRight->layout()->addWidget(container);
    ui->frameRight->layout()->removeWidget(ui->frameRightContents);
    l->addWidget(ui->frameRightContents);


    NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 10, titleBarHeight)];
    NSTitlebarAccessoryViewController *_dummyTitlebarAccessoryViewController = [NSTitlebarAccessoryViewController new];
    _dummyTitlebarAccessoryViewController.view = view;
    _dummyTitlebarAccessoryViewController.fullScreenMinHeight = titleBarHeight;
    [nswindow addTitlebarAccessoryViewController:_dummyTitlebarAccessoryViewController];


    NSArray *_standardButtons = @[[nswindow standardWindowButton:NSWindowCloseButton],
                         [nswindow standardWindowButton:NSWindowMiniaturizeButton],
                         [nswindow standardWindowButton:NSWindowZoomButton]];

    [_standardButtons enumerateObjectsUsingBlock:^(NSButton *standardButton, NSUInteger idx, BOOL *stop) {

        NSRect frame = standardButton.frame;
        frame.origin.y = NSHeight(standardButton.superview.frame)/2-NSHeight(standardButton.frame)/2;
        frame.origin.x = _trafficLightButtonsLeftMargin +idx*(NSWidth(frame) + 6);
        [standardButton setFrame:frame];
    }];

    [pool release];
}

MainWindow::~MainWindow()
{
    delete ui;
}
