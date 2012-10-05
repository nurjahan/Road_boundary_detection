
1. Detect edges using brightness, color, texture
2. Take pixels based on thresholding
3. Convert pixels X-Y coordinate to polar coordinate
4. Do clustering with the help of Dendogram
5. Do confidence assignment to each cluster
6. Take top ranked clusters
7. Show top ranked cluster by connecting each pixel of the cluster with line
8. show mean line of each cluster 
9. Do perspective filtering to each pair of the mean line
Upto this Same as previous version
Problem with curved road:
	Set high confidence to the cluster whose memebers have same polar distance and angle.In curved road, the cluster contains 
original boundary points get lower confidence as members have same polar angle but different polar distance.

Not Solved....
## image reference 340.jpg