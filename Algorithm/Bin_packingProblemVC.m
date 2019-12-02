//
//  Bin_packingProblemVC.m
//  Algorithm
//
//  Created by Teonardo on 2019/12/2.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "Bin_packingProblemVC.h"

#define GOODS_COUNT 10    // 定义物品的数量
#define BOX_VOLUME  20    // 定义箱子的容积

// 物品节点
typedef struct goods {
    int num;             // 物品编号
    CGFloat volume;      // 物品体积
    struct goods *next;  // 指向下一个物品
} GoodsNode;

// 箱子节点
typedef struct box {
    CGFloat remainder;     // 箱子剩余体积
    GoodsNode *goodsHead;  // 物品头节点
    struct box *next;      // 指向下一个箱子
} BoxNode;



@interface Bin_packingProblemVC ()

@end

@implementation Bin_packingProblemVC

// 构造物品数据
void prepareGoodsData(GoodsNode* arr[])
{
    float temp_volume_arr[GOODS_COUNT] = {3, 1, 5, 7, 18, 10, 12, 11, 14, 15};
    for (int i = 0; i < GOODS_COUNT; i++) {
        GoodsNode *goods = (GoodsNode *)malloc(sizeof(GoodsNode));
        (*goods).num = i;
        (*goods).volume = temp_volume_arr[i];
        (*goods).next = NULL;
        arr[i] = goods;
    }
}

// 排序
void sortDescending(GoodsNode* arr[])
{
    for (int i = 0; i < GOODS_COUNT; i ++) {
        for (int j = i; j < GOODS_COUNT - i - 1; j ++) {
            if ((*arr[j]).volume > (*arr[j+1]).volume) {
                GoodsNode temp = *arr[j];
                *arr[j] = *arr[j+1];
                *arr[j+1] = temp;
            }
        }
    }
}

// 创建一个箱子
BoxNode * createBox(void)
{
    BoxNode *box = (BoxNode *)malloc(sizeof(BoxNode));
    (*box).remainder = BOX_VOLUME;
    (*box).goodsHead = NULL;
    (*box).next = NULL;
    return box;
}

// 装箱
BoxNode * pack(GoodsNode* arr[])
{
    BoxNode *box_head = NULL;  // 箱子头节点
    BoxNode *box_p = NULL;     // 遍历箱子时,用来记录当前的节点
    
    // 初始化
    box_head = createBox();
    
    // 每次从排序的物品中取出一个物品, 然后遍历箱子, 看能哪个箱子能放得下.
    for (int i = 0; i < GOODS_COUNT; i++) {
        
        // 从头开始遍历箱子
        box_p = box_head;
        
        // 1 取出物品
        GoodsNode *goods = arr[i];  // !!!:错误写法 GoodsNode goods = *(arr[i]);
        
        // 2 寻找可以放得下的箱子
        while ((*box_p).remainder < (*goods).volume) {
            // 后面没有箱子了, 打开新的箱子
            if ((*box_p).next == NULL) {
                box_p = ((*box_p).next = createBox());
            }
            // 后面有已经打开了的箱子, 使指针移动, 指向该箱子
            else {
                box_p = (*box_p).next;
            }
        }
        
        // 放在物品链最后
        // 确定物品位置
        GoodsNode *goods_p = NULL;
        if ((*box_p).goodsHead) {  // 如果物品链存在
            goods_p = (*box_p).goodsHead;
            while ((*goods_p).next) {
                goods_p = (*goods_p).next;
            }
            (*goods_p).next = goods;
        }
        else { // 物品链不存在
            
            (*box_p).goodsHead = goods;
        }
        
        // 容积变化
        (*box_p).remainder -= (*goods).volume;
        
    }
    
    return box_head;
    
}

// 输出
void printBox(BoxNode *box)
{
    BoxNode *box_p = box;  // 记录在遍历过程中指向的箱子
    
    int box_count = 0;
    
    while (box_p != NULL) {
        printf("箱子剩余容积: %f \n", (*box_p).remainder);
        
        GoodsNode *goods_p = (*box_p).goodsHead;
        
        while (goods_p != NULL) {
            printf("    物品编号: %d, 体积:%f \n", (*goods_p).num, (*goods_p).volume);
            goods_p = (*goods_p).next;
        }
        printf("\n");
        
        box_p = (*box_p).next;
        box_count++;
    }
    
    printf("一共用了%d个箱子", box_count);
}


- (void)test {
    GoodsNode* goods[GOODS_COUNT] = {0};
    // 构造数据
    prepareGoodsData(goods);
    // 排序
    sortDescending(goods);
    // 装箱
    BoxNode *box_head = pack(goods);
    // 输出
    printBox(box_head);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test];
}

@end
