import 'package:flutter/material.dart';
import 'package:weatherlight/constants.dart';
import 'package:weatherlight/widgets/player_widget_dialogs/show_combo_tracker.dart';
import 'dart:math' as math;
import 'package:weatherlight/widgets/player_widget_dialogs/show_player_lp_history_dialog.dart';

class ShowPlayerStatusDialog {
  static void showPlayerDialog(
    BuildContext context,
    List<int> cmdDamage,
    List<int> lifeHistory,
    int playerCount,
    bool knockOut,
    bool infinite,
    void Function(int) updateLP,
    void Function(int, int) updateCD,
    void Function(int, int) updatePlayerCounters,
    List<int> playerCounters,
    Color shadowColor,
    Color poisonColor,
    Color experienceColor,
    Color energyColor,
    Color radiationColor,
  ) {
    RotatedBox? parentRotatedBox =
        context.findAncestorWidgetOfExactType<RotatedBox>();
    if (parentRotatedBox != null) {
      double rotation = parentRotatedBox.quarterTurns *
          90 %
          360; // Adjust the rotation to avoid exceeding 360 degrees
      showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return _buildDialog(
            context,
            rotation,
            cmdDamage,
            lifeHistory,
            playerCount,
            knockOut,
            infinite,
            updateLP,
            updateCD,
            updatePlayerCounters,
            playerCounters,
            shadowColor,
            poisonColor,
            experienceColor,
            energyColor,
            radiationColor,
          );
        },
      );
    }
  }

  static Widget _buildDialog(
    BuildContext context,
    double rotation,
    List<int> cmdDamage,
    List<int> lifeHistory,
    int playerCount,
    bool knockOut,
    bool infinite,
    void Function(int) updateLP,
    void Function(int, int) updateCD,
    void Function(int, int) updatePlayerCounters,
    List<int> playerCounters,
    Color shadowColor,
    Color poisonColor,
    Color experienceColor,
    Color energyColor,
    Color radiationColor,
  ) {
    return Transform.rotate(
      angle: rotation * (math.pi / 180),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: SizedBox(
          width: 400,
          height: 400,
          child: RotatedBox(
            quarterTurns: 3,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return _buildDialogContent(
                  context,
                  rotation,
                  cmdDamage,
                  lifeHistory,
                  playerCount,
                  knockOut,
                  infinite,
                  updateLP,
                  updateCD,
                  updatePlayerCounters,
                  playerCounters,
                  shadowColor,
                  poisonColor,
                  experienceColor,
                  energyColor,
                  radiationColor,
                  setState,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildDialogContent(
    BuildContext context,
    double rotation,
    List<int> cmdDamage,
    List<int> lifeHistory,
    int playerCount,
    bool knockOut,
    bool infinite,
    void Function(int) updateLP,
    void Function(int, int) updateCD,
    void Function(int, int) updatePlayerCounters,
    List<int> playerCounters,
    Color shadowColor,
    Color poisonColor,
    Color experienceColor,
    Color energyColor,
    Color radiationColor,
    StateSetter setState,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLPHistoryButton(context, lifeHistory, rotation),
                const SizedBox(height: 10),
                _buildComboTrackerButton(context, rotation),
              ],
            ),
            const SizedBox(width: 10),
            _buildPlayerDamageWidgets(
              context,
              cmdDamage,
              playerCount,
              knockOut,
              infinite,
              updateLP,
              updateCD,
              setState,
            ),
            const SizedBox(width: 10),
            _buildPlayerCounterWidgets(
              context,
              updatePlayerCounters,
              playerCounters,
              poisonColor,
              experienceColor,
              energyColor,
              radiationColor,
              setState,
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildLPHistoryButton(
    BuildContext context,
    List<int> lifeHistory,
    double rotation,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            ShowPlayerLPHistory.showLPHistoryDialog(
                context, lifeHistory, rotation);
          },
          child: SizedBox(
            width: 180, // Set the same width for both buttons
            height: 50, // Set the same height for both buttons
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'LP-History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildComboTrackerButton(
    BuildContext context,
    double rotation,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            ShowComboTracker.showComboTrackerDialog(context, rotation);
          },
          child: SizedBox(
            width:
                180, // Match this width and height with the LP-History button
            height: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Combo Tracker',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildPlayerDamageWidgets(
    BuildContext context,
    List<int> cmdDamage,
    int playerCount,
    bool knockOut,
    bool infinite,
    void Function(int) updateLP,
    void Function(int, int) updateCD,
    StateSetter setState,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < playerCount; i += 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildPlayerDamageWidget(
                context,
                cmdDamage,
                i,
                updateLP,
                updateCD,
                knockOut,
                infinite,
                setState,
              ),
              if (i + 1 < playerCount)
                _buildPlayerDamageWidget(
                  context,
                  cmdDamage,
                  i + 1,
                  updateLP,
                  updateCD,
                  knockOut,
                  infinite,
                  setState,
                ),
            ],
          ),
      ],
    );
  }

  static Widget _buildPlayerDamageWidget(
    BuildContext context,
    List<int> cmdDamage,
    int index,
    void Function(int) updateLP,
    void Function(int, int) updateCD,
    bool knockOut,
    bool infinite,
    StateSetter setState,
  ) {
    return GestureDetector(
      onTap: () {
        if (!knockOut && !infinite) {
          updateLP(-1);
        }
        updateCD(index, 1);
        setState(() {}); // Trigger rebuild after state change
      },
      onLongPress: () {
        if (!knockOut && !infinite) {
          updateLP(1);
        }
        updateCD(index, -1);
        setState(() {}); // Trigger rebuild after state change
      },
      child: Container(
        width: dialogButtonSize,
        height: dialogButtonSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.black,
          image: const DecorationImage(
            image: AssetImage("images/CMM.jpg"),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${cmdDamage[index]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              color: Colors.white24.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              shadows: [
                for (double i = 1; i < 10; i++)
                  Shadow(
                    color: shadowColorCommanderDamage,
                    blurRadius: 3 * i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildPlayerCounterWidgets(
    BuildContext context,
    void Function(int, int) updatePlayerCounters,
    List<int> playerCounters,
    Color poisonColor,
    Color experienceColor,
    Color energyColor,
    Color radiationColor,
    StateSetter setState,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildPlayerCounterWidget(
          context,
          updatePlayerCounters,
          playerCounters[0],
          0,
          "images/poison.png",
          poisonColor,
          setState,
        ),
        const SizedBox(height: 5),
        _buildPlayerCounterWidget(
          context,
          updatePlayerCounters,
          playerCounters[1],
          1,
          "images/experience.png",
          experienceColor,
          setState,
        ),
        const SizedBox(height: 5),
        _buildPlayerCounterWidget(
          context,
          updatePlayerCounters,
          playerCounters[2],
          2,
          "images/energy.png",
          energyColor,
          setState,
        ),
        const SizedBox(height: 5),
        _buildPlayerCounterWidget(
          context,
          updatePlayerCounters,
          playerCounters[3],
          3,
          "images/radiation.png",
          radiationColor,
          setState,
        ),
      ],
    );
  }

  static Widget _buildPlayerCounterWidget(
    BuildContext context,
    void Function(int, int) updatePlayerCounters,
    int counterValue,
    int counterIndex,
    String imagePath,
    Color counterColor,
    StateSetter setState,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          updatePlayerCounters(counterIndex, 1);
        });
      },
      onLongPress: () {
        setState(() {
          updatePlayerCounters(counterIndex, -1);
        });
      },
      child: Container(
        width: dialogButtonSize,
        height: dialogButtonSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(imagePath),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$counterValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              color: Colors.white24.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              shadows: [
                for (double i = 1; i < 10; i++)
                  Shadow(
                    color: counterColor,
                    blurRadius: 3 * i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
