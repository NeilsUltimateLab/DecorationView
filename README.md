# DecorationView

This project demonstrates use of UICollectionView's decorationView to draw custom path over collectionView cells. 


![Simulator Screen Shot - iPhone 13 mini - 2022-08-22 at 20 08 20](https://user-images.githubusercontent.com/23612211/185948539-55f49eec-c428-453a-8973-837e25bfecaf.png)

## Key-classes

- RoadMapLayout: UICollectionViewFlowLayout
  - Registers `RoadMapView` as a decorationView.
  - Provides layout attributes for registered decorationView (`RoadMapView`).  
- RoadMapLayoutAttributes: UICollectionViewLayoutAttributes
  - A subclass to define some decorative properties and a callback closure for user interaction on decorationView. 
- RoadMapView: UICollectionReusableView
  - A subclass to perform drawing of the Road line ui using some CGRect maths. 
