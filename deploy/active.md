# 激活

## 激活设备

激活码可重复使用，但限定只能激活绑定到一台设备上，且限制单容器实例

当前激活数据保存在数据库中，多机器部署或者单机器中使用不同的挂载目录多实例部署，都会触发激活限制

> [!TIP] 激活数据库
> 保存在数据目录中的`res.db`数据库中，数据目录是指容器内`/wechat2rss`目录

## 取消激活

提供自助取消激活功能，提交后自动重置激活信息，并将当前所有设备取消激活

重启服务即可重新激活绑定

<script module>
export default {
  data() {
    return {
      email: "",
      code: "",
      status: "",
    };
  },
  methods: {
    submit() {
      if (!(this.email && this.code)) {
        this.status = "输入邮箱和激活码";
        return;
      }
      this.status = "提交中...";

      fetch("/auth/clear", {
        method: "POST",
        header: {
          "content-type": "application/json;charset=utf-8",
        },
        body: JSON.stringify({
          email: this.email,
          code: this.code,
        }),
      })
        .then((res) => res.json())
        .then((res) => {
          console.info("code send", res);
          if (res.ok) {
            this.status = res.data;
          } else {
            console.error(res.err);
            this.status = res.err;
          }
        })
        .catch((e) => {
          console.error(e);
          this.status = e.message;
        });
    },
  },
};

</script>

<style module>
.input {
  border: 1px solid;
  border-radius: 4px;
}
.button {
  font-weight: bold;
}
</style>

邮箱：<input :class="$style.input" v-model="email">

激活码：<input :class="$style.input" v-model="code">

状态：{{ status }}

<button :class="$style.button" @click="submit">提交反激活</button>