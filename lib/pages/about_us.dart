import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    const int paragraphSpacing = 6;
    const int titleSubtitleSpacing = 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(fontSize: 4 * 8, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Card(
              child: Padding(
        padding: const EdgeInsets.all(8.0 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: Text(
                  "Welcome to Smart Fiber, an innovative solution transforming the abaca fiber industry through cutting-edge technology. Our Abaca Grading System, powered by YOLO (You Only Look Once), revolutionizes the way abaca fibers are graded, ensuring efficiency, accuracy, and quality consistency for farmers, processors, and stakeholders in the abaca value chain.",
                  style: TextStyle(fontSize: 4 * 5),
                ))
              ],
            ),
            const SizedBox(
              height: 8.0 * paragraphSpacing,
            ),
            Text(
              "Our Mission",
              style: TextStyle(fontSize: 4 * 8, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8.0 * titleSubtitleSpacing,
            ),
            Row(
              children: [
                Flexible(
                    child: Text(
                  "At Smart Fiber, we are committed to enhancing the livelihoods of abaca farmers and supporting sustainable industry growth by leveraging artificial intelligence (AI). By providing a streamlined and objective grading system, we aim to promote transparency, reduce waste, and elevate the global competitiveness of abaca products.",
                  style: TextStyle(fontSize: 4 * 5),
                ))
              ],
            ),
            const SizedBox(
              height: 8.0 * paragraphSpacing,
            ),
            Text(
              "What We Do",
              style: TextStyle(fontSize: 4 * 8, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8.0 * titleSubtitleSpacing,
            ),
            Row(
              children: [
                Flexible(
                    child: Text(
                  "Using the YOLO algorithm, our system automates the grading process by identifying and categorizing abaca fibers based on their quality in real-time. This AI-powered solution minimizes human error, accelerates processing times, and ensures standardized results, empowering producers with reliable data for decision-making.",
                  style: TextStyle(fontSize: 4 * 5),
                ))
              ],
            ),
            const SizedBox(
              height: 8.0 * paragraphSpacing,
            ),
            Text(
              "Why Choose Smart Fiber?",
              style: TextStyle(fontSize: 4 * 8, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8.0 * titleSubtitleSpacing,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 4 * 4),
                children: const <TextSpan>[
                  TextSpan(
                    text: '1. Efficiency: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Our system dramatically reduces the time required for fiber grading, enabling faster production cycles.\n\n',
                  ),
                  TextSpan(
                    text: '2. Accuracy: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'YOLO\'s advanced object detection ensures consistent and precise grading outcomes.\n\n',
                  ),
                  TextSpan(
                    text: '3. Sustainability: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'By minimizing resource wastage and optimizing the value of harvested fibers, we contribute to a greener future.\n\n',
                  ),
                  TextSpan(
                    text: '4. Empowerment: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'We equip stakeholders with the tools to achieve greater profitability and resilience in the global market.',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0 * paragraphSpacing,
            ),
            Text(
              "Our Vision",
              style: TextStyle(fontSize: 4 * 8, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8.0 * titleSubtitleSpacing,
            ),
            Row(
              children: [
                Flexible(
                    child: Text(
                  "We envision a future where technology bridges tradition and innovation, fostering a thriving abaca industry that sustains both communities and the environment. Through Smart Fiber, we aspire to set new standards for agricultural innovation and support the enduring legacy of abaca as a vital natural resource.",
                  style: TextStyle(fontSize: 4 * 5),
                ))
              ],
            ),
            const SizedBox(
              height: 8.0 * paragraphSpacing,
            ),
            Row(
              children: [
                Flexible(
                    child: Text(
                  "Join us on our journey to redefine excellence in abaca fiber grading and make a lasting impact on the industry!",
                  style: TextStyle(fontSize: 4 * 5),
                ))
              ],
            ),
          ],
        ),
      ))),
    );
  }
}
