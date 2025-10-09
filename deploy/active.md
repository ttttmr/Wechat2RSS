# 激活

## 激活设备

激活码可重复使用，但限定只能激活绑定到一台设备上，且限制单容器实例

当前激活数据保存在数据库中，多机器部署或者单机多实例部署都会触发激活限制

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

      fetch("https://wechat2rss.xlab.app/auth/clear", {
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
          console.info("clear res", res);
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
    query() {
      if (!(this.email && this.code)) {
        this.status = "输入邮箱和激活码";
        return;
      }
      this.status = "查询中...";

      fetch("https://wechat2rss.xlab.app/auth/query", {
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
          console.info("query res", res);
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
  padding: 4px 12px;
  border-radius: 4px;
  border: 1px solid #1c6edb;
  background-color: #4f9cff;
  color: white;
  margin-right: 10px;
}
.status {
  white-space: pre-wrap;
}
</style>

邮箱：<input :class="$style.input" v-model="email">

激活码：<input :class="$style.input" v-model="code">

<button :class="$style.button" @click="query">查询</button> <button :class="$style.button" @click="submit">反激活</button>

结果：

<div :class="$style.status">{{ status }}</div>
