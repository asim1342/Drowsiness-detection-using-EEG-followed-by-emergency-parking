# Drowsiness-detection-using-EEG-followed-by-emergency-parking
This project focuses on developing an autonomous system to detect drowsiness in drivers and prevent road accidents. Microsleep, which is caused by inadequate sleep, is a leading cause of road accidents. The system uses EEG signals to detect the driver's drowsy state with an accuracy of 96.8%.

## How it works
The system is based on the observation that the occipital region of the brain is most affected when a person shifts from an awake state to a drowsy state. A sudden downward shift in alpha waves followed by oscillation in the theta band is used as a feature for detecting drowsiness. The signal is preprocessed using smoothing, digital filtering, and data standardization.

The preprocessed data is then fed to a machine learning algorithm to classify the state of the driver (normal or drowsy). The system is capable of classifying 10,000 observations per second, making it fast and accurate.

Instead of using multiple channels for drowsiness detection, our study suggests that only one channel (O1 of the occipital region) is sufficient to effectively detect drowsiness.

An autonomous system is implemented on a miniature car as a proof of concept. It parks the car itself after successful lane detection on to the parking lane, minimizing the risk of accidents.

## Code
The code is written in MATLAB and consists of various functions for preprocessing the signal, creating filters, and training the machine learning algorithm. The code is available in the code directory.

## Dataset
The dataset used for this project is publicly available and consists of EEG signals from drivers in both normal and drowsy states. The dataset is available in the data directory.

## Conclusion
The proposed system is an effective way to prevent road accidents caused by drowsy driving. By detecting the driver's drowsy state in real-time and taking corrective actions, such as alerting the driver or initiating autonomous driving, the system can significantly reduce the risk of accidents. The study also highlights the importance of using EEG signals for drowsiness detection and the effectiveness of using a single channel for this purpose.
