# Fall-detection-app

The idea of this project is to develope a mobile application which can detect falls by using just the smartphone itself and a smartwatch. As the current existing products for fall detection usually require the user to wear some additional sensors, an app using only smartphone and smartwatch is more flexible.

## Data
270 falls were collected from 7 different people to increase diversity. A mattress was used when simulating falls.

## Accuracy
The highest accuracy we could achieve was 93.33% for falls (true positive), while maintaining a decent accuracy of 84.44% for ADL (true negative). The true positive conditions are far more important than true negative conditions, so it's a good combination when in use.

The threshold of heuristic function can be adjusted to fit the desired sensitivity (depends on how active the user usually is).

The best combination we found to achieve 93.33% true positive accuracy is:
- 32 ms for sampling rate
- 750 ms sliding window for data processing
- [3, 50] for threshold

## Findings
Adding more ADL data does improve the performance of predicting ADL, but it’s a tradeoff which may weaken the ability of predicting fall.
Considering phone acceleration on top of the prediction can filter out more ADLs, which reduces false positive rate. 


## Required devices
An Android smartphone and a Microsoft Band.
The minimum Android version was 7.0 at the moment of testing.

## Tested devices
This app has been tested on multiple brands of Android smartphones including:
- LG
- Samsung
- Sony
- Huawei


## Installation
See [Documentation](Documentation/FallDetection_Guide_2017.pdf).


## Published Paper
The paper about this project was published. If you want to understand the details, you can find it at [RonPub](https://www.ronpub.com/ojiot/OJIOT_2018v4i1n07_Ngu.html) or [Here](Paper/Smartwatch-Based%20IoT%20Fall%20Detection%20Application.pdf).
