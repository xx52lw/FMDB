//
//  ViewController.m
//  LWCoreData
//
//  Created by liwei on 16/11/9.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "Person.h"
#import "DataBase.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *personName;
- (IBAction)addBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *updateSex;
@property (weak, nonatomic) IBOutlet UITextField *updateName;
- (IBAction)upateBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *deleteName;
- (IBAction)deleteBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *selectName;

- (IBAction)selectBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *carPerson;

@property (weak, nonatomic) IBOutlet UITextField *brandText;

@property (weak, nonatomic) IBOutlet UITextField *priceText;


- (IBAction)carAdd:(id)sender;

- (IBAction)carUpdate:(id)sender;

- (IBAction)carDelete:(id)sender;

- (IBAction)carSelect:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *tableName;

@property (weak, nonatomic) IBOutlet UITextField *columnName;

- (IBAction)add:(id)sender;


- (IBAction)tableDrop:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}



- (IBAction)addBtn:(id)sender {
    
    Person *person = [[Person alloc] init];
    person.name = self.personName.text;
    
    [[DataBase sharedDataBase] addPerson:person];
}

- (IBAction)upateBtn:(id)sender {
    
    Person *person = [[Person alloc] init];
    person.name = self.updateName.text;
    person.sex = self.updateSex.text;
    person.userID = @"100";
    [[DataBase sharedDataBase] updatePerson:person];
    
}
- (IBAction)deleteBtn:(id)sender {
    
    Person *person = [[Person alloc] init];
    person.name = self.deleteName.text;

    [[DataBase sharedDataBase] deletePerson:person];
}


- (IBAction)selectBtn:(id)sender {
    
    Person *person = [[Person alloc] init];
    person.name = self.selectName.text;
    NSMutableArray *arr = [[DataBase sharedDataBase] selectPerson:person];
    NSLog(@"");
}



- (IBAction)carAdd:(id)sender {
    
    Person *person = [[Person alloc] init];
    person.name = self.carPerson.text;
    person = [[DataBase sharedDataBase] selectPerson:person].firstObject;
    
    Car *car = [[Car alloc] init];
    car.brand = self.brandText.text;
    car.price = self.priceText.text;
    [[DataBase sharedDataBase] addCar:car toPerson:person];
    
}

- (IBAction)carUpdate:(id)sender {
}

- (IBAction)carDelete:(id)sender {
}

- (IBAction)carSelect:(id)sender {
}



- (IBAction)add:(id)sender {
    
    [[DataBase sharedDataBase] tableName:self.tableName.text column:self.columnName.text];
    
}

- (IBAction)tableDrop:(id)sender {
    [[DataBase sharedDataBase] deleteTableName:self.tableName.text column:self.columnName.text];
}
@end
