abstract class Failure {
  final String message;

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message =
        'ارتباط با سرور با مشکل مواجه شد. لطفاً ۱ دقیقه بعد دوباره تلاش کنید.',
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message =
        'اتصال به اینترنت برقرار نیست. لطفاً اتصال اینترنت خود را بررسی کنید و دوباره تلاش کنید.',
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'دسترسی شما به این بخش مجاز نیست.',
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'خطایی رخ داده است. لطفاً دوباره تلاش کنید.',
  });
}
