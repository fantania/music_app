import 'package:fantania_music_app/consts/colors.dart';
import 'package:fantania_music_app/consts/text_style.dart';
import 'package:fantania_music_app/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        size: 48,
                        color: whiteColor,
                      ),
                    ))),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(children: [
                  Text(
                    data[controller.playIndex.value].displayNameWOExt,
                    style: getTextStyle(textSize: 24, textColor: bgColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data[controller.playIndex.value].artist.toString(),
                    style: getTextStyle(textSize: 20, textColor: bgColor),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Row(
                      children: [
                        Text(controller.position.value,
                            style: getTextStyle(textColor: bgDarkColor)),
                        Expanded(
                            child: Slider(
                                thumbColor: sliderColor,
                                activeColor: sliderColor,
                                inactiveColor: bgColor,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDurationToSeconds(
                                      newValue.toInt());
                                  newValue = newValue;
                                })),
                        Text(
                          controller.duration.value,
                          style: getTextStyle(textColor: bgDarkColor),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 40,
                          color: bgDarkColor,
                        ),
                      ),
                      Obx(
                        () => CircleAvatar(
                          radius: 35,
                          backgroundColor: bgDarkColor,
                          child: Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                              onPressed: () {
                                if (controller.isPlaying.value) {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying(false);
                                } else {
                                  controller.audioPlayer.play();
                                  controller.isPlaying(true);
                                }
                              },
                              icon: controller.isPlaying.value
                                  ? const Icon(
                                      Icons.pause,
                                      color: whiteColor,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_rounded,
                                      color: whiteColor,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 40,
                          color: bgDarkColor,
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
