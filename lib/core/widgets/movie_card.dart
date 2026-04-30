import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/features/auth/view_model/auth_states.dart';
import 'package:movies/features/auth/view_model/auth_view_model.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(Routes.movieDetails, arguments: movie.id),
      child: Container(
        margin: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadiusDirectional.all(
                  Radius.circular(24.r),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      movie.largeCoverImage ??
                      movie.mediumCoverImage ??
                      movie.smallCoverImage,
                  errorWidget: (context, url, error) => Image.network(
                    'https://4ddig.tenorshare.com/images/photo-recovery/images-not-found.jpg',
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: height * 0.01,
              left: width * 0.02,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorManager.background.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      '${movie.rating}',
                      style: getRegularStyle(
                        color: ColorManager.white,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      IconsAssets.star,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        ColorManager.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: height * 0.01,
              right: width * 0.02,
              child: BlocBuilder<AuthViewModel, AuthState>(
                builder: (context, state) {
                  final authViewModel = context.read<AuthViewModel>();

                  final isFavorite = authViewModel.checkMovieIsFavorite(
                    movie.id.toString(),
                  );

                  return Container(
                    decoration: BoxDecoration(
                      color: ColorManager.background.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          authViewModel.removeMovieFromFavorites(
                            movie.id.toString(),
                          );
                        } else {
                          authViewModel.addMovieToFavorites(
                            movie.id.toString(),
                          );
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: ColorManager.primary,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
