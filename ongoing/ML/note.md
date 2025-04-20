As is mentioned before, we apply various methods to solve the image segmenation problem. It can be regarded as a pixel classification problem and be solved using random forest algorithm. In the following slides, I will cover how i apply the algorithm to the problem. The advanatage of applying random forest are that it can handle outlier and high-dimensional data (such as pixel) well. In addition, random forest algorithm resist over-fitting well. However, the nearness or spatial continity information is missing during the training. the problem Handles Complexity: It thrives on high-dimensional data (pixels, textures, edges).



Part 2: Gini Impurity vs. Information Gain
As is well known, Gini Impurity and Information Gain are two popular criteria for splitting nodes in decision trees. Both are used to determine how well a feature separates the classes in a dataset. In the context of image segmentation, Gini Impurity is perferred for performance and efficiency. Because Gini skips log calculations, making it 10–20% faster; also gini impurity perform better with small numbers of category, which is the case for image segmentation. What's more Gini impurity is less sensitive to class imbalance, making it ideal for pixel classification which class is imbalanced.


Part 3:
Hyperparameters: tree numbers, depth are the two most important hyperparameters for random forest training. I start with 100–200 trees—enough for diversity, and limit tree depth to avoid overfitting. Among different parameter set, I use cross-validation to find the best parameters. 
The reuslt in the middle is a typical example of segmentation prediction. As you can see, the result is not satisfactory for retina.

My reflection is the only using RGB values for pixel classification. Retina are generally darker than its surrounding area. And different images have different brightness. So even same RGB values may belong to different classes for image segmentaion. 
We are considering to add gradient and surrounding pixel information to the model for better performance.

