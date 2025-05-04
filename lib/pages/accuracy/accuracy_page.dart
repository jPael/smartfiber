import 'package:flutter/material.dart';
import 'package:smartfiber/components/rich_text/custom_rich_text.dart';

class AccuracyPage extends StatelessWidget {
  const AccuracyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4 * 8.0, vertical: 8 * 2),
          child: CustomRichText(
            content: [
              CustomRichText.page(
                  context: context,
                  title: "Step 1: Data Collection and Annotation",
                  children: [
                    CustomRichText.image("assets/images/accuracy/image_1.png"),
                    CustomRichText.paragraph([
                      CustomRichText.bold("Process: "),
                      CustomRichText.text(
                          "Gather diverse and high-quality abaca fiber images across various grades."),
                    ]),
                    CustomRichText.paragraph([
                      CustomRichText.bold("Input: "),
                      CustomRichText.text("Abaca images (captured or sourced)."),
                    ]),
                  ]),
              CustomRichText.page(context: context, title: "Step 2: Data Preprocessing", children: [
                CustomRichText.image("assets/images/accuracy/image_2.png"),
                CustomRichText.paragraph([
                  CustomRichText.bold("Process: "),
                  CustomRichText.newLine(),
                  CustomRichText.numberized([
                    "Resize all images to match YOLO's input dimensions.",
                    "Normalize pixel values to scale them between 0 and 1.",
                    "Apply augmentations like flipping, rotation, and brightness adjustment to improve model generalization."
                  ])
                ]),
                CustomRichText.paragraph(
                    [CustomRichText.bold("Input: "), CustomRichText.text("Raw annotated images.")])
              ]),
              CustomRichText.page(
                  context: context,
                  title: "Step 3: Model Training with YOLO",
                  children: [
                    CustomRichText.image("assets/images/accuracy/image_3.png"),
                    CustomRichText.paragraph([
                      CustomRichText.bold("Process: "),
                      CustomRichText.newLine(),
                      CustomRichText.numberized([
                        "Load the YOLO architecture with pretrained weights.",
                        "Train the model on abaca dataset, adjusting hyperparameters like learning rate, batch size.",
                        "Optimize using YOLO’s loss functions.",
                      ]),
                    ]),
                    CustomRichText.paragraph([
                      CustomRichText.bold("Input: "),
                      CustomRichText.text("Preprocessed images and annotations."),
                    ])
                  ]),
              CustomRichText.page(context: context, title: "Step 4: Model Evaluation", children: [
                CustomRichText.image("assets/images/accuracy/image_4.png"),
                CustomRichText.paragraph([
                  CustomRichText.bold("Process: "),
                  CustomRichText.newLine(),
                  CustomRichText.numberized([
                    "Validate the model using a test set with metrics like accuracy, precision, recall, and mean Average Precision (mAP).",
                    "Perform k-fold cross-validation to ensure robustness.",
                    "Identify and analyze errors for further improvements.",
                  ]),
                ]),
                CustomRichText.paragraph([
                  CustomRichText.bold("Input: "),
                  CustomRichText.text("Trained YOLO model and test dataset."),
                ])
              ]),
              CustomRichText.page(
                  context: context,
                  title: "Step 5: Continuous Improvement",
                  children: [
                    CustomRichText.image("assets/images/accuracy/image_5.png"),
                    CustomRichText.paragraph([
                      CustomRichText.bold("Process: "),
                      CustomRichText.newLine(),
                      CustomRichText.numberized([
                        "Retrain the model using additional data from misclassifications.",
                        "Regularly update the dataset with new images and features to adapt to evolving grading needs.",
                        "Use techniques like pruning and quantization to improve model efficiency without sacrificing accuracy.",
                      ]),
                    ]),
                    CustomRichText.paragraph([
                      CustomRichText.bold("Input: "),
                      CustomRichText.text("Feedback from model evaluation and new data."),
                    ])
                  ]),
            ],
          )),
    );
  }
}
