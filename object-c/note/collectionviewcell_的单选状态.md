## CollectionViewCell 的单选状态
> 千万不要用百度搜索，

> 千万不要用百度搜索，

> 千万不要用百度搜索，



[请叫我雷锋，不谢](http://stackoverflow.com/questions/18857167/uicollectionview-cell-selection)


### **UICollectionViewCell**

	- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
	{
    static NSString *cellIdentifier = @"Cell";

    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.imageView.image = ...

    if (self.selectedItemIndexPath != nil && [indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
        cell.imageView.layer.borderColor = [[UIColor redColor] CGColor];
        cell.imageView.layer.borderWidth = 4.0;
    } else {
        cell.imageView.layer.borderColor = nil;
        cell.imageView.layer.borderWidth = 0.0;
    }

    return cell;
	}
	
	
### **didSelectedCell**
	- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // always reload the selected cell, so we will add the border to that cell

    NSMutableArray *indexPaths = [NSMutableArray arrayWithObject:indexPath];

    if (self.selectedItemIndexPath)
    {
        // if we had a previously selected cell

        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame)
        {
            // if it's the same as the one we just tapped on, then we're unselecting it

            self.selectedItemIndexPath = nil;
        }
        else
        {
            // if it's different, then add that old one to our list of cells to reload, and
            // save the currently selected indexPath

            [indexPaths addObject:self.selectedItemIndexPath];
            self.selectedItemIndexPath = indexPath;
        }
    }
    else
    {
        // else, we didn't have previously selected cell, so we only need to save this indexPath for future reference

        self.selectedItemIndexPath = indexPath;
    }

    // and now only reload only the cells that need updating

    [collectionView reloadItemsAtIndexPaths:indexPaths];
	}