import 'package:flutter/material.dart';
import 'package:smartfiber/components/rich_text/custom_rich_text.dart';

class ModelFlowPage extends StatelessWidget {
  const ModelFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4 * 8.0, vertical: 8 * 2),
          child: CustomRichText(
            content: [
              CustomRichText.page(
                  centerTitle: true,
                  title: "Input Image Data",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_1.png"),
                    CustomRichText.paragraph([
                      CustomRichText.text(
                          "The process begins with uploading or capturing an image of abaca fibers using a mobile application or camera.")
                    ])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Divide Image into Grid",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_2.png"),
                    CustomRichText.paragraph(
                        [CustomRichText.text("The image is split into smaller grid cells.")])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Feature Detection",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_3.png"),
                    CustomRichText.paragraph([
                      CustomRichText.text(
                          "The model extracts important visual features like texture and edges.")
                    ])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Class Probability Prediction",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_4.png"),
                    CustomRichText.paragraph([
                      CustomRichText.text(
                          "Each grid cell predicts the probability of abaca fiber grades.")
                    ])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Bounding Box Prediction",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_5.png"),
                    CustomRichText.paragraph([
                      CustomRichText.text(
                          "The model predicts possible object locations with bounding boxes.")
                    ])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Combine Predictions (Bounding Boxes + Classes)",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_6.png"),
                    CustomRichText.paragraph([
                      CustomRichText.text(
                          "Each grid cell predicts the probability of abaca fiber grades.")
                    ])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Confidence Threshold Check",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_7.png"),
                    CustomRichText.paragraph(
                        [CustomRichText.text("The system filters out low-confidence detection.")])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Non-Maximum Suppression (NMS)",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_8.png"),
                    CustomRichText.paragraph([
                      CustomRichText.text(
                          "Redundant boxes are removed, keeping only the best prediction.")
                    ])
                  ]),
              CustomRichText.page(
                  centerTitle: true,
                  title: "Final Detection Result",
                  context: context,
                  children: [
                    CustomRichText.image("assets/images/model_flow/image_9.png"),
                    CustomRichText.paragraph([
                      CustomRichText.text(
                          "The application displays the abaca fiber grade and quality result.")
                    ])
                  ]),
            ],
          )),
    );
  }
}
