<template>
  <div class="wrapper">
    <div class="http404-container">
      <img
        class="pic"
        src="@/assets/404_images/404.png"
        alt="">
      <div class="title">Ops! Địa chỉ truy cập của bạn không tồn tại</div>
      <div class="desc">Vui lòng kiểm tra lại địa chỉ hoặc trở về trang chủ</div>
      <div
        class="btn"
        @click="handleBack">
        GO HOME
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: 'Page404',
  methods: {
    handleBack() {
      this.$router.push('/')
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.wrapper {
  position: relative;
}

.http404-container {
  position: relative;
  top: 50%;
  transform: translateY(-50%);
  .pic {
    width: 600px;
    display: block;
    margin: 0 auto;
  }
  .title {
    width: 100%;
    text-align: center;
    font-size: 24px;
    color: #111;
    line-height: 38px;
    margin-top: 77px;
  }
  .desc {
    width: 100%;
    font-size: 18px;
    color: #777;
    text-align: center;
    line-height: 38px;
    margin-top: 8px;
  }
  .btn {
    width: 125px;
    height: 44px;
    text-align: center;
    font-size: 14px;
    color: #fefefe;
    line-height: 44px;
    background: #3e84e9;
    border-radius: 6px;
    margin: 50px auto 0;
    cursor: pointer;
  }
}

@media screen and (max-width: 1500px) {
  .http404-container {
    .pic {
      width: 500px;
    }
    .title {
      margin-top: 50px;
    }
    .btn {
      margin-top: 40px;
    }
  }
}
</style>
