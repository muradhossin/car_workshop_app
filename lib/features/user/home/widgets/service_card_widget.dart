import 'package:car_workshop_app/base_widgets/custom_image_view_widget.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';

class ServiceCardWidget extends StatefulWidget {
  final ServiceModel service;

  const ServiceCardWidget({super.key, required this.service});

  @override
  ServiceCardState createState() => ServiceCardState();
}

class ServiceCardState extends State<ServiceCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomImageViewer(
                imageUrl: widget.service.imageUrl,
                height: 180,
                width: double.infinity,
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add to cart action
                  },
                  child: Text('Add to Cart'),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.service.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.service.price.toStringAsFixed(2)} ${AppConstants.currencySymbol}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isExpanded
                      ? widget.service.description
                      : widget.service.description.length > 50
                      ? '${widget.service.description.substring(0, widget.service.description.length > 100 ? 100 : widget.service.description.length)} ${widget.service.description.length > 100 ? '...' : ''}'
                      : widget.service.description,
                  maxLines: _isExpanded ? null : 2,
                  overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
                if (widget.service.description.length > 100)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_isExpanded ? 'Read Less' : 'Read More', style: TextStyle(color: Colors.blue)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}