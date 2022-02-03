import 'package:flutter/material.dart';

class AnimeSearchBar extends StatelessWidget {
  AnimeSearchBar({
    Key? key,
    this.height = 56,
    this.radius = 28,
    this.onSearched,
    this.borderColor = const Color.fromRGBO(27, 29, 33, 0.1),
  }) : super(key: key);

  final void Function(String query)? onSearched;
  final Color borderColor;
  final double radius;
  final double height;

  final TextEditingController _controller = TextEditingController();
  final String _hint = 'Bir anime ara...';

  final double _buttonSize = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: _buildOutline(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildTextField(context), _buildSearchButton()],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Expanded(
      child: Center(
        child: TextField(
          controller: _controller,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontFamily: 'DMSans-Regular',
              letterSpacing: -0.3,
              color: const Color.fromRGBO(4, 4, 21, 1)),
          decoration: _buildDecoration(),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      onPressed: () => onSearched?.call(_controller.text),
      icon: Container(
        height: _buttonSize,
        width: _buttonSize,
        child: const Icon(Icons.search_outlined),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(237, 251, 255, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  BoxDecoration _buildOutline() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: _hint,
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontFamily: 'DMSans-Italic',
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.all(16),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }
}
