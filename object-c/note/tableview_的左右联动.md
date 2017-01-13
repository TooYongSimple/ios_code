## tableview 的左右联动
1 .右侧滑动的时候左侧也滑动


    #pragma mark -- 右侧的tableView联动左侧的tableview
	- (void)setLeftTableViewCellSelectedState:(NSInteger)section 	{
    	BOOL isContinue = false;
   	 	NSUInteger totalRows = 0;
	    NSIndexPath *index = nil;
    
    for (int i = 0; i < self.leftDataArr.count; i++) {
        for (int j = 0; j < [self.leftDataArr[i] count]; j++) {
            if (section == totalRows) {
                index = [NSIndexPath indexPathForRow:j inSection:i];
                isContinue = YES;
                break;
            }
            totalRows ++;
        }
        if (isContinue) {
            break;
        }
    }
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index.row inSection:index.section] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self changeLeftTableViewCellSelectedState:index];
}

	- (void)changeLeftTableViewCellSelectedState:(NSIndexPath *)indexPath {
    NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:0];
    for (NSArray *arr in self.leftDataArr) {
        NSMutableArray *classArr = [NSMutableArray arrayWithCapacity:0];
        for (HKLeftClassModel *model in arr) {
            model.state = HKClassLeftCellStateNone;
            [classArr addObject:model];
        }
        [newArr addObject:classArr];
    }
    self.leftDataArr = newArr;
    HKLeftClassModel *model = self.leftDataArr[indexPath.section][indexPath.row];
    model.state = HKClassLeftCellStateSelected;
    [self.leftTableView reloadData];

	}
	
2. 左侧点击定位到右侧的位置

#pragma mark - 一级tableView滚动时 实现当前类tableView的
	
	
	

	- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
    NSUInteger totalRows = 0;
    NSUInteger currentRow = 0;
    HKLeftClassModel *currentModel  	self.leftDataArr[indexPath.section][indexPath.row];
    for (NSArray *arr in self.leftDataArr) {
        for (HKLeftClassModel *model in arr) {
            if ([model isEqual:currentModel]) {
                currentRow = totalRows;
            }
            totalRows++;
        }
    }
    //如果 section 下没有值的话，row 的数组为空，不能定位到 0 的位置，导致程序奔溃，所以得判断一下 该section下是否有值
    HKLog(@"这是左侧的section = %lu， 这是右侧所有的section = %lu", (unsigned long)currentRow, (unsigned long)self.rightDataArr.count);
    if (self.rightDataArr.count > 0) {
        if ([self.rightDataArr[currentRow][@"goodsList"] isKindOfClass:[NSNull class]]) {
            return;
        }
        else {
            HKLog(@"这是该Section 下的数据 = %@",self.rightDataArr[currentRow][@"goodsList"]);
            if ([self.rightDataArr[currentRow][@"goodsList"] count] > 0) {
                [self.rightTableView selectRowAtIndexPath:([NSIndexPath indexPathForRow:0 inSection:currentRow]) animated:YES scrollPosition:UITableViewScrollPositionTop];
            }
            return;
            
        }

    }
}

