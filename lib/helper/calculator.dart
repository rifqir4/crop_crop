part of crop_crop;

class Calculator {
  Calculator._();

  static Rect calcInitialRectZone(Rect imgRect) {
    final width = imgRect.shortestSide;
    final center = (imgRect.longestSide - width) / 2;
    final isVertical = imgRect.width < imgRect.height;
    if (isVertical) {
      return Rect.fromLTWH(imgRect.left, center, width, width);
    } else {
      return Rect.fromLTWH(center, imgRect.top, width, width);
    }
  }

  static Rect calcImgRect(Size layoutSize, Size imageSize) {
    final isVertical = imageSize.aspectRatio < layoutSize.aspectRatio;
    if (isVertical) {
      final imageScreenWidth = layoutSize.height * imageSize.aspectRatio;
      final left = (layoutSize.width - imageScreenWidth) / 2;
      final right = left + imageScreenWidth;
      return Rect.fromLTWH(left, 0, right - left, layoutSize.height);
    } else {
      final imageScreenHeight = layoutSize.width / imageSize.aspectRatio;
      final top = (layoutSize.height - imageScreenHeight) / 2;
      final bottom = top + imageScreenHeight;
      return Rect.fromLTWH(0, top, layoutSize.width, bottom - top);
    }
  }

  static Rect calcZoneToImg(Rect zoneRect, Rect imgRect, Size imageSize) {
    final ratio = imageSize.height / imgRect.height;
    final width = zoneRect.width * ratio;
    final height = zoneRect.height * ratio;
    final left = (zoneRect.left - imgRect.left) * ratio;
    final top = (zoneRect.top - imgRect.top) * ratio;
    return Rect.fromLTWH(left, top, width, height);
  }

  static Rect moveZone(
    double deltaX,
    double deltaY,
    Rect original,
    Rect layout,
  ) {
    if (original.left + deltaX < layout.left) {
      deltaX = (original.left - layout.left) * -1;
    }
    if (original.right + deltaX > layout.right) {
      deltaX = layout.right - original.right;
    }
    if (original.top + deltaY < layout.top) {
      deltaY = (original.top - layout.top) * -1;
    }
    if (original.bottom + deltaY > layout.bottom) {
      deltaY = layout.bottom - original.bottom;
    }

    return Rect.fromLTWH(
      original.left + deltaX,
      original.top + deltaY,
      original.width,
      original.height,
    );
  }

  static Rect dragTopLeftZone(
    double deltaX,
    double deltaY,
    Rect original,
    Rect layout,
    double? aspectRatio,
  ) {
    final newLeft = math.max(
      layout.left,
      math.min(original.left + deltaX, original.right - 40),
    );
    final newTop = math.min(
      math.max(original.top + deltaY, layout.top),
      original.bottom - 40,
    );
    if (aspectRatio == null) {
      return Rect.fromLTRB(
        newLeft,
        newTop,
        original.right,
        original.bottom,
      );
    } else {
      if (deltaX.abs() > deltaY.abs()) {
        var newWidth = original.right - newLeft;
        var newHeight = newWidth / aspectRatio;
        if (original.bottom - newHeight < layout.top) {
          newHeight = original.bottom - layout.top;
          newWidth = newHeight * aspectRatio;
        }

        return Rect.fromLTRB(
          original.right - newWidth,
          original.bottom - newHeight,
          original.right,
          original.bottom,
        );
      } else {
        var newHeight = original.bottom - newTop;
        var newWidth = newHeight * aspectRatio;
        if (original.right - newWidth < layout.left) {
          newWidth = original.right - layout.left;
          newHeight = newWidth / aspectRatio;
        }
        return Rect.fromLTRB(
          original.right - newWidth,
          original.bottom - newHeight,
          original.right,
          original.bottom,
        );
      }
    }
  }

  static Rect dragTopRightZone(
    double deltaX,
    double deltaY,
    Rect original,
    Rect layout,
    double? aspectRatio,
  ) {
    final newTop = math.min(
      math.max(original.top + deltaY, layout.top),
      original.bottom - 40,
    );
    final newRight = math.max(
      math.min(original.right + deltaX, layout.right),
      original.left + 40,
    );
    if (aspectRatio == null) {
      return Rect.fromLTRB(
        original.left,
        newTop,
        newRight,
        original.bottom,
      );
    } else {
      if (deltaX.abs() > deltaY.abs()) {
        var newWidth = newRight - original.left;
        var newHeight = newWidth / aspectRatio;
        if (original.bottom - newHeight < layout.top) {
          newHeight = original.bottom - layout.top;
          newWidth = newHeight * aspectRatio;
        }

        return Rect.fromLTWH(
          original.left,
          original.bottom - newHeight,
          newWidth,
          newHeight,
        );
      } else {
        var newHeight = original.bottom - newTop;
        var newWidth = newHeight * aspectRatio;
        if (original.left + newWidth > layout.right) {
          newWidth = layout.right - original.left;
          newHeight = newWidth / aspectRatio;
        }
        return Rect.fromLTRB(
          original.left,
          original.bottom - newHeight,
          original.left + newWidth,
          original.bottom,
        );
      }
    }
  }

  static Rect dragBottomLeftZone(
    double deltaX,
    double deltaY,
    Rect original,
    Rect layout,
    double? aspectRatio,
  ) {
    final newLeft = math.max(
      layout.left,
      math.min(original.left + deltaX, original.right - 40),
    );
    final newBottom = math.max(
      math.min(original.bottom + deltaY, layout.bottom),
      original.top + 40,
    );
    if (aspectRatio == null) {
      return Rect.fromLTRB(
        newLeft,
        original.top,
        original.right,
        newBottom,
      );
    } else {
      if (deltaX.abs() > deltaY.abs()) {
        var newWidth = original.right - newLeft;
        var newHeight = newWidth / aspectRatio;
        if (original.top + newHeight > layout.bottom) {
          newHeight = layout.bottom - original.top;
          newWidth = newHeight * aspectRatio;
        }

        return Rect.fromLTRB(
          original.right - newWidth,
          original.top,
          original.right,
          original.top + newHeight,
        );
      } else {
        var newHeight = newBottom - original.top;
        var newWidth = newHeight * aspectRatio;
        if (original.right - newWidth < layout.left) {
          newWidth = original.right - layout.left;
          newHeight = newWidth / aspectRatio;
        }
        return Rect.fromLTRB(
          original.right - newWidth,
          original.top,
          original.right,
          original.top + newHeight,
        );
      }
    }
  }

  static Rect dragBottomRightZone(
    double deltaX,
    double deltaY,
    Rect original,
    Rect layout,
    double? aspectRatio,
  ) {
    final newRight = math.min(
      layout.right,
      math.max(original.right + deltaX, original.left + 40),
    );
    final newBottom = math.max(
      math.min(original.bottom + deltaY, layout.bottom),
      original.top + 40,
    );
    if (aspectRatio == null) {
      return Rect.fromLTRB(
        original.left,
        original.top,
        newRight,
        newBottom,
      );
    } else {
      if (deltaX.abs() > deltaY.abs()) {
        var newWidth = newRight - original.left;
        var newHeight = newWidth / aspectRatio;
        if (original.top + newHeight > layout.bottom) {
          newHeight = layout.bottom - original.top;
          newWidth = newHeight * aspectRatio;
        }

        return Rect.fromLTWH(
          original.left,
          original.top,
          newWidth,
          newHeight,
        );
      } else {
        var newHeight = newBottom - original.top;
        var newWidth = newHeight * aspectRatio;
        if (original.left + newWidth > layout.right) {
          newWidth = layout.right - original.left;
          newHeight = newWidth / aspectRatio;
        }
        return Rect.fromLTWH(
          original.left,
          original.top,
          newWidth,
          newHeight,
        );
      }
    }
  }
}
