import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/mentor_model.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class MentorReviewList extends StatefulWidget {
  final List<MentorReview>? mentorReviews;

  const MentorReviewList({Key? key, this.mentorReviews}) : super(key: key);

  @override
  State<MentorReviewList> createState() => _MentorReviewListState();
}

class _MentorReviewListState extends State<MentorReviewList> {
  @override
  Widget build(BuildContext context) {
    final mentorReview = widget.mentorReviews;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            Text('Review'),
          ],
        ),
      ),
      body: mentorReview!.isEmpty
          ? Center(
              child: Text('Belum ada review'),
            )
          : ListView.builder(
              itemCount: mentorReview.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorStyle().tertiaryColors,
                        width: 2,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reviewer: ${mentorReview[index].reviewer?.name ?? ''}",
                            style: FontFamily().boldText.copyWith(
                                  fontSize: 14,
                                ),
                          ),
                          SizedBox(height: 16),
                          Text(mentorReview[index].content ?? '',
                              style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().disableColors,
                                  )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
