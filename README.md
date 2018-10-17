# Fall-detection-app

The idea of this project is to develope a mobile application which can detect falls by using just the smartphone itself and a smartwatch. As the current existing products for fall detection usually require the user to wear some additional sensors, an app using only smartphone and smartwatch is more flexible.


## Methodology


## Data
270 falls were collected from 7 different people to increase diversity. A mattress was used when simulating falls.




## Accuracy
The highest accuracy we could achieve was 93.33% for falls (true positive).

The threshold of heuristic function can be adjusted to fit the desired sensitivity (depends on how active the user usually is).

Adding more ADL data does improve the performance of predicting ADL, but it’s a tradeoff which may weaken the ability of predicting fall.

Considering phone acceleration on top of the prediction can filter out more ADLs, which reduces false positive rate. 

The best combination we found is:
- 32 ms for sampling rate
- 750 ms sliding window for data processing
- [3, 50] for threshold

## Required devices
An Android smartphone and a Microsoft Band.

## Tested devices
This app has been tested on multiple brands of Android smartphone including:
- LG
- Samsung
- Sony
- Huawei

The minimum Android version was 7.0 at the moment of testing.

## Installation
See document.


## Published Paper
The paper about this project was published. You can find it at [RonPub](https://www.ronpub.com/ojiot/OJIOT_2018v4i1n07_Ngu.html) or [Here](Paper/Smartwatch-Based%20IoT%20Fall%20Detection%20Application.pdf).
